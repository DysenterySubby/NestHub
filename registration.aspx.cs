using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;

namespace MOCKAirBNB
{
    public partial class registration : System.Web.UI.Page
    {
 
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void Register(object sender, EventArgs e)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                con.Open();
                using (var cmd = new SqlCommand($"exec nh_register @u_email='{tbEmail.Text}', @u_password='{tbPassword.Text}';", con))
                {
                    if (!cmd.ExecuteReader().Read())
                    {
                        if (tbPassword.Text == tbConfirmPassword.Text)
                        {
                            Session["Email"] = tbEmail.Text;
                            Response.Redirect("~/login.aspx");
                        }
                        else
                            Label1.Text = "Verify password";
                    }
                    else
                        Label1.Text = "Account Already Registered";
                }
            }
        }
    }
}