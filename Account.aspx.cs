using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;
using System.Diagnostics;

namespace MOCKAirBNB
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var task = Task.Run(async () => await GetUserListings());
            task.Wait();

            hfUserPicUrl.Value= (Session["User"] as User).IconURL;
            hfUserName.Value = (Session["User"] as User).Username;
            hfEmail.Value = (Session["User"] as User).Email;
        }

        protected void SelectedListing(object sender, EventArgs e)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();

            var task = Task.Run(async () => {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                {
                    await con.OpenAsync();
                    using (var cmd = new SqlCommand($"GetListing", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PropID", hfListing.Value);
                        using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                        {
                            await reader.ReadAsync();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                if (reader.GetName(i) == "Username")
                                    row["UserPic"] = NestHubAzureBlobService.GetProfilePicture(reader[i].ToString());
                                row[reader.GetName(i)] = reader[i];
                            }
                            row["ImgURLS"] = NestHubAzureBlobService.GetListingPictures(hfListing.Value);
                        }
                    }
                }
            });
            task.Wait();

            string json = JsonConvert.SerializeObject(row, Newtonsoft.Json.Formatting.Indented);
            File.WriteAllText(Server.MapPath("~/Data/listing.json"), json);
            Response.Redirect($"~/Listing.aspx");
        }

        protected async Task GetUserListings()
        {
            //Retrieves User's Owned Properties and Stores it to a json file
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                using (var cmd = new SqlCommand("GetUserListingList", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", ((User)Session["User"]).UserID);
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
                File.WriteAllText(Server.MapPath("~/Data/userlistinglist.json"), json);
            }
            //Retrieves user's booked properties and stores it to a json file
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                using (var cmd = new SqlCommand("GetUserBooking", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", ((User)Session["User"]).UserID);
                    await connection.OpenAsync();
                    SqlDataReader reader = await cmd.ExecuteReaderAsync();
                    while (await reader.ReadAsync())
                    {
                        Dictionary<string, object> row = new Dictionary<string, object>
                        {
                            { "BookingID", reader["BookingID"]},
                            { "StartDate", DateTime.Parse(reader["StartDate"].ToString()).ToString("MMMM d, yyyy") },
                            { "EndDate", DateTime.Parse(reader["EndDate"].ToString()).ToString("MMMM d, yyyy")},
                            { "PropImgUrl", NestHubAzureBlobService.GetListingPic(reader["PropID"].ToString())},
                            { "IsRated", reader["IsRated"].ToString()}
                        };
                        rows.Add(row);
                    }
                    reader.Close();
                }
                string json = JsonConvert.SerializeObject(rows, Newtonsoft.Json.Formatting.Indented);
                File.WriteAllText(Server.MapPath("~/Data/userbookinglist.json"), json);
            }

        }

        protected void SelectedRating(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                using (var cmd = new SqlCommand("InsertRating", connection))
                {
                    string bookingID = hfRating.Value.Split(';')[1];
                    int rating = Convert.ToInt32(hfRating.Value.Split(';')[0]);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BookingID", bookingID);
                    cmd.Parameters.AddWithValue("@NewRating",rating);
                    connection.Open();
                    cmd.ExecuteNonQuery();   
                }
            }
            Response.Redirect("~/Account.aspx");
        }
    }
}