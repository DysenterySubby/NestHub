using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOCKAirBNB
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("~/Stays.aspx");
            }
            HiddenField hfCurrentPage = Master.FindControl("hfCurrentPage") as HiddenField;
            hfCurrentPage.Value = "HostPage";
        }

        

        protected void UploadListing(object sender, EventArgs e)
        {
            string newPropID = "";
            if(hfPropType.Value != "Select")
            {
                var task = Task.Run(async () =>
                {
                    using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                    {
                        await con.OpenAsync();

                        using (var cmd = new SqlCommand("InsertProperty", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@UserID", (Session["User"] as User).UserID);
                            cmd.Parameters.AddWithValue("@PropName", tbpropertyName.Text);
                            cmd.Parameters.AddWithValue("@PropAdd", tbAddress.Text);
                            cmd.Parameters.AddWithValue("@PropBrgy", tbBarangay.Text);
                            cmd.Parameters.AddWithValue("@PropCity", tbCity.Text);
                            cmd.Parameters.AddWithValue("@PropProvince", tbProvince.Text);
                            cmd.Parameters.AddWithValue("@PropType", hfPropType.Value);
                            cmd.Parameters.AddWithValue("@PricePerNight", double.Parse(tbPrice.Text));
                            cmd.Parameters.AddWithValue("@PropReview", 0.0);
                            SqlDataReader reader = cmd.ExecuteReader();
                            reader.Read();

                            newPropID = reader["PropID"].ToString();
                        }
                    }
                });
                task.Wait();
                NestHubAzureBlobService.UploadListingImages(fuListing.PostedFiles, newPropID);
                Response.Redirect("~/Stays.aspx");

            }
        }
    }
}