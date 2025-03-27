using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOCKAirBNB
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenField hfCurrentPage = Master.FindControl("hfCurrentPage") as HiddenField;
            hfCurrentPage.Value = "Stays";
            //var task = Task.Run(async () => await GetHomeListings());
            //task.Wait();
        }

        protected void SelectedListing(object sender, EventArgs e)
        {
            //Dictionary<string, object> row = new Dictionary<string, object>();

            //var task = Task.Run(async () => {
            //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            //    {
            //        await con.OpenAsync();
            //        using (var cmd = new SqlCommand($"getlisting", con))
            //        {
            //            cmd.CommandType = CommandType.StoredProcedure;
            //            cmd.Parameters.AddWithValue("@PropID", hfListing.Value);
            //            using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
            //            {
            //                await reader.ReadAsync();
            //                for (int i = 0; i < reader.FieldCount; i++)
            //                {
            //                    if (reader.GetName(i) == "Username")
            //                        row["UserPic"] = NestHubAzureBlobService.GetProfilePicture(reader[i].ToString());
            //                    row[reader.GetName(i)] = reader[i];
            //                }
            //                row["ImgURLS"] = NestHubAzureBlobService.GetListingPictures(hfListing.Value);
            //            }
            //        }
            //    }
            //});
            //task.Wait();

            //string json = JsonConvert.SerializeObject(row, Newtonsoft.Json.Formatting.Indented);
            //File.WriteAllText(Server.MapPath("~/Data/listing.json"), json);
            Response.Redirect($"~/Listing.aspx");
        }

        //GETS ALL THE LISTINGS AND STORE IT IN A JSON FILE
        protected async Task GetHomeListings()
        {
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                using (var cmd = new SqlCommand("GetListingList", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Where", Session["Where"] ?? "");
                    cmd.Parameters.AddWithValue("@Checkin", Session["Checkin"] ?? "");
                    cmd.Parameters.AddWithValue("@Checkout", Session["Checkout"] ?? "");
                    await connection.OpenAsync();
                    SqlDataReader reader = await cmd.ExecuteReaderAsync();
                    while (await reader.ReadAsync())
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
                File.WriteAllText(Server.MapPath("~/Data/listinglist.json"), json);

                Session["Where"] = null;
                Session["Checkin"] = null;
                Session["Checkout"] = null;
            }
        }
    }
}