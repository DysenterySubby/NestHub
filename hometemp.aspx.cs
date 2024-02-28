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
using static System.Net.Mime.MediaTypeNames;

namespace MOCKAirBNB
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["Username"]!= null)
            {
                //ClientScript.RegisterStartupScript(this.GetType(), "loginStatus", "isRegistered=true;", true);
            }
        }

        protected void Login(object sender, EventArgs e)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                DataTable result = new DataTable();
                con.Open();

                using (var cmd = new SqlCommand($"exec nh_login @u_email='{tbEmail.Text}', @u_password='{tbPassword.Text}';", con))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "closeLogin", $"$('#SignupUsername').modal('hide');", true);
                        Session["Username"] = reader.GetString(1);
                        Session["Email"] = tbEmail.Text.ToString();
                    }
                }
            }
        }



        protected void Register(object sender, EventArgs e)
        {
            if (tbRegPassword.Text == tbRegConfirmPassword.Text)
            {
                using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                {
                    con.Open();
                    using (var cmd = new SqlCommand($"exec nh_register @u_email='{tbRegEmail.Text}', @u_password='{tbRegPassword.Text}';", con))
                    {
                        if (!cmd.ExecuteReader().Read())
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "openUsernameSignup", $"$('#SignupUsername').modal('show');", true);
                            Session["Email"] = tbRegEmail.Text;
                        }
                    }
                }
            }
        }

        protected void KeepLogin_Changed(object sender, EventArgs e)
        {
            Session["KeepLogin"] = cbKeepLogin.Checked;
        }

        protected async void UsernameRegister(object sender, EventArgs e)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                con.Open();
                using (var cmd = new SqlCommand($"exec nh_registeremail @u_username='{tbUsername.Text}', @u_email='{Session["Email"]}';", con))
                {
                    if (!cmd.ExecuteReader().Read())
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "finishRegistration", $"$('#SignupUsername').modal('hide');", true);
                        Session["Username"] = tbUsername.Text;
                        if (newProfilePhoto.HasFile)
                        {
                            using (Stream fileStream = newProfilePhoto.PostedFile.InputStream)
                            {
                                NestHubAzureBlobService blob = new NestHubAzureBlobService();
                                await blob.UploadProfilePicture(Session["Username"].ToString(), Path.GetFileName(newProfilePhoto.FileName), fileStream);
                            }
                        }
                    }
                }
            }
        }
    }
}