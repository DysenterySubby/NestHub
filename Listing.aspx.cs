using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MOCKAirBNB
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenField hfCurrentPage = Master.FindControl("hfCurrentPage") as HiddenField;
            hfCurrentPage.Value = "Listing";

            using (StreamReader r = new StreamReader(Server.MapPath(@"~/Data/listing.json"), true))
            {
                string json = r.ReadToEnd();
                Session["Listing"] = JsonConvert.DeserializeObject<Item>(json);
            }
        }

        public class Item
        {
            public string PropID;
            public string PropName;
            public string PropAddress;
            public double PricePerNight;
            public double PropReview;
            public string UserEmail;
        }

        protected void ListingReserved(object sender, EventArgs e)
        {
            try
            {
                if (Session["User"] != null)
                {
                    DateTime checkIn;
                    DateTime checkOut;
                    if (DateTime.TryParse(tbCheckin.Text, out checkIn) && DateTime.TryParse(tbCheckout.Text, out checkOut))
                    {
                        using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                        {
                            con.Open();
                            using (SqlCommand cmd = new SqlCommand("InsertBooking", con))
                            {
                                Item listing = Session["Listing"] as Item;
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@UserID", ((User)Session["User"]).UserID);
                                cmd.Parameters.AddWithValue("@PropID", listing.PropID);
                                cmd.Parameters.AddWithValue("@Payment", ((checkOut.Date - checkIn.Date).TotalDays + 1) * listing.PricePerNight);
                                cmd.Parameters.AddWithValue("@StartDate", checkIn.Date);
                                cmd.Parameters.AddWithValue("@EndDate", checkOut.Date);
                                SqlDataReader reader = cmd.ExecuteReader();
                                if (reader.Read() && reader["DateAvailable"].ToString() == "True")
                                {
                                    Response.Redirect("~/Account.aspx");
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidateDate", $"UpdateHostPageFields('Book the property with a date later than {DateTime.Parse(reader["NextAvailableDate"].ToString()).ToString("MMMM d, yyyy")}');", true);
                                }
                            }
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "ValidateDate", $"UpdateHostPageFields('Please enter a valid date!');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidateDate", $"$('#Login').modal('show');", true);
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('{ex.Message}');</script>");
            }
            
        }

        protected void DateChanged(object sender, EventArgs e)
        {
            if (DateTime.TryParse(tbCheckin.Text, out var checkin) && DateTime.TryParse(tbCheckout.Text, out var checkout))
            {
                if(checkin > checkout)
                {
                    tbCheckin.Text = checkout.ToString("yyyy-MM-dd");
                    tbCheckout.Text = checkout.AddDays(1).ToString("yyyy-MM-dd");
                }
                else
                {
                    Item listing = Session["Listing"] as Item;
                    ScriptManager.RegisterStartupScript(DateUpdatePanel, DateUpdatePanel.GetType(), "UpdatePrice", $"document.getElementById('listingPrice').innerHTML = \"&#8369; \" + '{((checkout.Date - checkin.Date).TotalDays + 1) * listing.PricePerNight:n2}';", true);
                }
            }

            tbCheckin.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
            tbCheckout.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    
}