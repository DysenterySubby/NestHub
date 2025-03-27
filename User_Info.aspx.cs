using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Caching;
using MOCKAirBNB;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Drawing;
using System.Web.UI.HtmlControls;

namespace NestHub_BackEnd
{
    public partial class User_Info : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var User = Session["User"] as User;
                if (User == null || (User.UserType != "Admin" && User.UserType != "Staff"))
                    Response.Redirect("~/Stays.aspx");

                

                if (!IsPostBack)
                {
                    BindGridView();
                }
            }
            catch (NullReferenceException)
            {
                Response.Redirect("~/Stays.aspx");
            }
        }
        private void BindGridView()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                using (var cmd = new SqlCommand($"GetUserList", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserType", (Session["User"] as User).UserType);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();

                        adapter.Fill(table);
                        GridView1.DataSource = table;
                        GridView1.DataBind();
                    }
                }
                    
            }
        }

        protected void UserDeleting_Event(object sender, GridViewDeleteEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                con.Open();
                // Create a new SqlCommand with the query and the connection
                using (SqlCommand cmd = new SqlCommand($"DeleteUserListingList", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", GridView1.DataKeys[e.RowIndex].Value);
                    con.OpenAsync();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        NestHubAzureBlobService.DeleteListingBlob(reader["PropID"].ToString());
                    }
                    reader.Close();
                }
            }
            NestHubAzureBlobService.DeleteUserpicBlob(GridView1.Rows[e.RowIndex].Cells[3].Text);
            BindGridView();
        }

        protected void UserSelecting_Event(object sender, GridViewSelectEventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetUserListingList", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", GridView1.DataKeys[e.NewSelectedIndex].Value);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();

                        adapter.Fill(table);

                        Session["SelectedUserID"] = GridView1.DataKeys[e.NewSelectedIndex].Value;

                        GridView2.DataSource = table;
                        GridView2.DataBind();
                    }
                }
                
            }
        }

        protected void ListingDeleting_Event(object sender, GridViewDeleteEventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                connection.Open();
                // Create a new SqlCommand with the query and the connection
                using (SqlCommand cmd = new SqlCommand("DeleteListing", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PropID", GridView2.DataKeys[e.RowIndex].Value);
                    cmd.ExecuteNonQuery();
                }
            }
            NestHubAzureBlobService.DeleteListingBlob(GridView2.DataKeys[e.RowIndex].Value.ToString());
            Response.Redirect("~/User_Info.aspx");
        }
    }
}