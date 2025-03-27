using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Xml.Linq;
using System.Threading.Tasks;
using System.Text.Json.Serialization;
using System.Xml;
using Newtonsoft.Json;
using System.Web.UI.HtmlControls;

namespace MOCKAirBNB
{
    public partial class home1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            GetHomeListings();
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["User"] != null)
            {
                User sessionUser = (Session["User"] as User);
                if (sessionUser.UserType != "User")
                    Response.Redirect("~/User_Info.aspx");
            }
            if (!IsPostBack)
            {
                ViewState["ListingUploaded"] = false;
            }
            isLogged.Value = Session["User"] != null ? NestHubAzureBlobService.GetProfilePicture((Session["User"] as User).IconURL) : "";
        }

        //GETS ALL THE LISTINGS AND STORE IT IN A JSON FILE
        protected void GetHomeListings()
        {
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                using (var command = new SqlCommand("SELECT * FROM Property", connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Dictionary<string, object> row = new Dictionary<string, object>();
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            row[reader.GetName(i)] = reader[i];
                        }
                        row["PropImgUrl"] = NestHubAzureBlobService.GetListingPic(row["PropID"].ToString());
                        rows.Add(row);
                    }
                    reader.Close();
                }
                string json = JsonConvert.SerializeObject(rows, Newtonsoft.Json.Formatting.Indented);
                File.WriteAllText(Server.MapPath("~/Images/test.json"), json);
            }
        }

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
                        var user = new User(reader["UserID"].ToString(), reader["UserName"].ToString(), reader["UserType"].ToString());
                        Session["User"] = user;
                        isLogged.Value = user.IconURL = NestHubAzureBlobService.GetProfilePicture(user.Username);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        protected async void Login(object sender, EventArgs e)
        {
            if (await LoginAccount(tbEmail.Text, tbPassword.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "postback", "__doPostBack();", true);
            }
        }
        
        protected void Register(object sender, EventArgs e)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                con.Open();
                using (var cmd = new SqlCommand($"exec checkuserexists @Value='{tbEmailReg.Text}', @Type='email';", con))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    if(reader.Read() & reader["UserExists"].ToString() == "False" && tbPasswordReg.Text == tbPasswordConfirmReg.Text)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "RegisterStepTwo", "document.getElementById(\"regFirst\").style.display = \"none\"; document.getElementById(\"regSec\").style.display = \"block\";", true);
                    }
                }
            }
        }

        protected async void UsernameRegister(object sender, EventArgs e)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                con.Open();
                using (var cmd = new SqlCommand($"exec checkuserexists @Value='{tbUsernameReg.Text}', @Type='username';", con))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read() && reader["UserExists"].ToString() == "False")
                    {
                        await CreateAccount();
                        if (fuProfilePhoto.HasFile)
                        {
                            using (Stream fileStream = fuProfilePhoto.PostedFile.InputStream)
                            {
                                await NestHubAzureBlobService.UploadProfilePicture(tbUsernameReg.Text, Path.GetFileName(fuProfilePhoto.FileName), fileStream);
                            }
                        }
                        await LoginAccount(tbEmailReg.Text, tbPasswordReg.Text);
                    }
                    
                }
            }
            
        }

        protected void Signout(object sender, EventArgs e)
        {
            isLogged.Value = "";
            Session.Abandon();
            Response.Redirect("~/home.aspx");

        }

        protected async Task CreateAccount()
        {
            string newUserID;
            string idExists;
            var connectionString = ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString;

            do
            {
                newUserID = MOCKAirBNB.User.GenerateUserID();
                idExists = await CheckUserIDExistsAsync(newUserID, connectionString);
            } while (idExists == "True");

            await RegisterAccountAsync(newUserID, tbEmailReg.Text, tbUsernameReg.Text, tbPasswordReg.Text, connectionString);
        }

        private async Task<string> CheckUserIDExistsAsync(string userID, string connectionString)
        {
            using (var con = new SqlConnection(connectionString))
            {
                await con.OpenAsync();
                using (SqlCommand cmd = new SqlCommand($"exec checkuserIDexists @NewID={userID};", con))
                {
                    using (SqlDataReader idReader = await cmd.ExecuteReaderAsync())
                    {
                        if (await idReader.ReadAsync())
                            return idReader["UserExists"].ToString();
                        else
                            return "False";
                    }
                }
            }
        }

        private async Task RegisterAccountAsync(string userID, string email, string username, string password, string connectionString)
        {
            using (var con = new SqlConnection(connectionString))
            {
                await con.OpenAsync();
                using (var cmd = new SqlCommand($"exec registeraccount @UserID='{userID}',@Email='{email}', @Username='{username}', @Password='{password}';", con))
                {
                    await cmd.ExecuteNonQueryAsync();
                }
            }
        }


        protected async void UploadListing(object sender, EventArgs e)
        {
            Random random = new Random();
            string randomDigits = "";
            for (int i = 0; i < 6; i++)
            {
                randomDigits += random.Next(0, 10);
            }

            await Task.Run(async () =>
            {
                using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                {
                    await con.OpenAsync();

                    using (var cmd = new SqlCommand("registerproperty", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserID", (Session["User"] as User).UserID);
                        cmd.Parameters.AddWithValue("@PropID", randomDigits);
                        cmd.Parameters.AddWithValue("@PropName", tbpropertyName.Text);
                        cmd.Parameters.AddWithValue("@PropAdd", tbAddress.Text);
                        cmd.Parameters.AddWithValue("@PropBrgy", tbBarangay.Text);
                        cmd.Parameters.AddWithValue("@PropCity", tbCity.Text);
                        cmd.Parameters.AddWithValue("@PropProvince", tbProvince.Text);
                        cmd.Parameters.AddWithValue("@PropType", hfPropType.Value);
                        cmd.Parameters.AddWithValue("@PricePerNight", double.Parse(tbPrice.Text));
                        cmd.Parameters.AddWithValue("@PropReview", 0.0);
                        await cmd.ExecuteNonQueryAsync();
                    }
                }
            });
            NestHubAzureBlobService.UploadListingImages(fuListing.PostedFiles, randomDigits);
            GetHomeListings();
            ViewState["ListingUploaded"] = true;
        }

        protected async void UpdateSelectedListing(object sender, EventArgs e)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                await connection.OpenAsync();

                using (var command = new SqlCommand($"SELECT top(1) * FROM Property where PropID = '{hfListing.Value}'", connection))
                {
                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                row[reader.GetName(i)] = reader[i];
                            }
                        }
                        row["ImgURLS"] = NestHubAzureBlobService.GetListingPictures(hfListing.Value);
                    }
                }
            }

            string json = JsonConvert.SerializeObject(row, Newtonsoft.Json.Formatting.Indented);
            File.WriteAllText(Server.MapPath("~/Data/listing.json"), json);
        }
    }
}