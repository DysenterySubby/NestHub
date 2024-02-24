using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;
using System.Threading.Tasks;
using System.IO.Pipes;

namespace MOCKAirBNB
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["Username"] != null)
            {
                if ((bool)Session["KeepLogin"])
                {
                    Response.Redirect("~/home.aspx");
                }
                else
                {
                    tbEmail.Text = Session["Email"].ToString();
                    Session.Abandon();
                }
            }
        }


        protected void Login(object sender, EventArgs e)
        {

            

            if (FileUpload1.HasFile)
            {
                using (Stream fileStream = FileUpload1.PostedFile.InputStream)
                {
                    Task taskOfDataTable = Task.Run(async () => await NestHubAzureBlobService.UploadProfilePicture(tbEmail.Text.Split('@')[0], Path.GetFileName(FileUpload1.FileName), fileStream));
                }
            }
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                DataTable result = new DataTable();
                con.Open();

                using (var cmd = new SqlCommand($"exec nh_login @u_email='{tbEmail.Text}', @u_password='{tbPassword.Text}';", con))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["Username"] = reader.GetString(1);
                        Session["Email"] = tbEmail.Text.ToString();

                        Response.Redirect("~/home.aspx");
                    }
                    else
                        Label1.Text = "Invalid credentials";
                }
            }
        }

        protected void KeepLogin_Changed(object sender, EventArgs e)
        {
            Session["KeepLogin"] = cbKeepLogin.Checked;
        }
    }
}