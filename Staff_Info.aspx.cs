using MOCKAirBNB;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.UI.HtmlControls;

namespace NestHub_BackEnd
{
    public partial class Staff_Info : System.Web.UI.Page
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
                con.Open();
                using (var cmd = new SqlCommand($"Select * from UserInfo where UserType = 'Admin' ", con))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);
                        Admin_Grid.DataSource = table;
                        Admin_Grid.DataBind();
                    }
                }

            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                con.Open();
                using (var cmd = new SqlCommand($"Select * from UserInfo where UserType = 'Staff'", con))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);
                        Team_Grid.DataSource = table;
                        Team_Grid.DataBind();
                    }
                }

            }
        }
    }
}