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

namespace MOCKAirBNB
{
    public partial class home1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
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
            if (tbPasswordReg.Text == tbPasswordConfirmReg.Text)
            {
                using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                {
                    con.Open();
                    using (var cmd = new SqlCommand($"exec nh_register @u_email='{tbEmailReg.Text}', @u_password='{tbPasswordReg.Text}';", con))
                    {
                        if (!cmd.ExecuteReader().Read())
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "openUsernameSignup", $"$('#SignupUsername').modal('show');", true);
                        }
                    }
                }
            }
        }

        //protected async void UsernameRegister(object sender, EventArgs e)
        //{
        //    using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
        //    {
        //        con.Open();
        //        using (var cmd = new SqlCommand($"exec nh_registeremail @u_username='{tbUsername.Text}', @u_email='{Session["Email"]}';", con))
        //        {
        //            if (!cmd.ExecuteReader().Read())
        //            {
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "finishRegistration", $"$('#SignupUsername').modal('hide');", true);
        //                if (newProfilePhoto.HasFile)
        //                {
        //                    using (Stream fileStream = newProfilePhoto.PostedFile.InputStream)
        //                    {
        //                        NestHubAzureBlobService blob = new NestHubAzureBlobService();
        //                        await blob.UploadProfilePicture(Session["Username"].ToString(), Path.GetFileName(newProfilePhoto.FileName), fileStream);
        //                    }
        //                }
        //            }
        //        }
        //    }
        //}
    }
}