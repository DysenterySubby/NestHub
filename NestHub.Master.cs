using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
namespace MOCKAirBNB
{
    public partial class test : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            
            if (Session["User"] != null)
            {
                User sessionUser = (Session["User"] as User);
                if (sessionUser.UserType != "User")
                    Response.Redirect("~/User_Info.aspx");
            }
            isLogged.Value = Session["User"] != null ? (Session["User"] as User).IconURL : "";
        }

        //GETS ALL THE LISTINGS AND STORE IT IN A JSON FILE
        protected async Task<bool> LoginAccount(string loginEmail, string loginPassword)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                await con.OpenAsync();
                using (var cmd = new SqlCommand("loginaccount", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Email", loginEmail);
                    cmd.Parameters.AddWithValue("@Password", loginPassword);

                    SqlDataReader reader = await cmd.ExecuteReaderAsync();
                    if (reader.Read() && reader["UserExists"].ToString() == "True")
                    {
                        Session["User"] = new User(reader["UserID"].ToString(), reader["UserName"].ToString(), reader["UserType"].ToString(), loginEmail);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        protected void Login(object sender, EventArgs e)
        {
            string email = tbEmail.Text;
            string password = tbPassword.Text;
            bool isLoggedIn=false;

            var task = Task.Run(async () => {
                isLoggedIn = await LoginAccount(email, password);
            });
            task.Wait();

            
            if (isLoggedIn)
            {
                Response.Redirect("~/Stays.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(LoginUpdatePanel, LoginUpdatePanel.GetType(), "Login", "UpdateLoginFieldDesign();", true);
            }
        }

        protected void Register(object sender, EventArgs e)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                con.Open();
                using (var cmd = new SqlCommand("checkuserexists", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Value", tbEmailReg.Text);
                    cmd.Parameters.AddWithValue("@Type", "email");
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read() & reader["UserExists"].ToString() == "False" && CredIsValid())
                    {
                        ScriptManager.RegisterStartupScript(RegisterUpdatePanel, RegisterUpdatePanel.GetType(), "RegisterStep", "document.getElementById(\"regFirst\").style.display = \"none\"; document.getElementById(\"regSec\").style.display = \"block\";", true);
                    }
                    else
                        ScriptManager.RegisterStartupScript(RegisterUpdatePanel, RegisterUpdatePanel.GetType(), "RegisterInvalidCredentials", $"UpdateEmailFieldDesign();", true);
                }
            }
        }

        bool CredIsValid()
        {
            if (tbPasswordReg.Text != tbPasswordConfirmReg.Text || tbPasswordReg.Text.Length  < 8)
            {
                if(tbPasswordReg.Text != tbPasswordConfirmReg.Text)
                    ScriptManager.RegisterStartupScript(RegisterUpdatePanel, RegisterUpdatePanel.GetType(), "RegisterInvalidCredentials", $"UpdateInputFieldDesign(false, 'Password and confirm password do not match. Please make sure your passwords match.');", true);
                else
                    ScriptManager.RegisterStartupScript(RegisterUpdatePanel, RegisterUpdatePanel.GetType(), "RegisterInvalidCredentials", $"UpdateInputFieldDesign(false, 'Password must be at least 8 characters long. Please choose a longer password.');", true);
                return false;
            }
            ScriptManager.RegisterStartupScript(RegisterUpdatePanel, RegisterUpdatePanel.GetType(), "RegisterInvalidCredentials", $"UpdateInputFieldDesign(true, '');", true);
            return true;
        }

        protected void UsernameRegister(object sender, EventArgs e)
        {
            bool isLoggedIn = false;
            var task = Task.Run(async () => {
                using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                {
                    con.Open();
                    using (var cmd = new SqlCommand("checkuserexists", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Value", tbUsernameReg.Text);
                        cmd.Parameters.AddWithValue("@Type", "username");
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read() && reader["UserExists"].ToString() == "False")
                        {
                            await RegisterAccountAsync();
                            if (fuProfilePhoto.HasFile)
                            {
                                using (Stream fileStream = fuProfilePhoto.PostedFile.InputStream)
                                {
                                    await NestHubAzureBlobService.UploadProfilePicture(tbUsernameReg.Text, Path.GetFileName(fuProfilePhoto.FileName), fileStream);
                                }
                            }
                            await LoginAccount(tbEmailReg.Text, tbPasswordReg.Text);
                            isLoggedIn = true;
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "RegisterStep", "$('#Signup').modal('show');", true);
                        }
                    }
                }
            });
            task.Wait();
            if(isLoggedIn)
                Response.Redirect("~/Stays.aspx");
        }
        private async Task RegisterAccountAsync()
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                await con.OpenAsync();
                using (var cmd = new SqlCommand($"InsertAccount", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Email", tbEmailReg.Text);
                    cmd.Parameters.AddWithValue("@Username", tbUsernameReg.Text);
                    cmd.Parameters.AddWithValue("@Password", tbPasswordReg.Text);
                    cmd.Parameters.AddWithValue("@UserNo", tbNumberReg.Text);
                    await cmd.ExecuteNonQueryAsync();
                }
            }
        }
        protected void Signout(object sender, EventArgs e)
        {
            isLogged.Value = "";
            Session.Abandon();
            Response.Redirect("~/Stays.aspx");
        }

        protected void Search(object sender, EventArgs e)
        {
            DateTime checkin, checkout;
            bool haveCheckin = DateTime.TryParse(searchCheckin.Text, out checkin);
            bool haveCheckout = DateTime.TryParse(searchCheckout.Text, out checkout);

            if (searchWhere.Text != "" || (haveCheckin && haveCheckout))
            {
                Session["Where"] = searchWhere.Text;
                if (checkin != null && checkin >= DateTime.Today)
                {
                    Session["Checkin"] = checkin;
                    Session["Checkout"] = checkout;
                }
                Response.Redirect("~/Stays.aspx");
            }
        }

        protected void DateChanged(object sender, EventArgs e)
        {
            if (DateTime.TryParse(searchCheckin.Text, out var checkin) && DateTime.TryParse(searchCheckout.Text, out var checkout))
            {
                if (checkin > checkout)
                {
                    searchCheckin.Text = checkout.ToString("yyyy-MM-dd");
                    searchCheckout.Text = checkout.AddDays(1).ToString("yyyy-MM-dd");
                }
            }
            searchCheckin.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
            searchCheckout.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
}