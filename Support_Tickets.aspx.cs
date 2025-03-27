using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using MOCKAirBNB;
using System.Web.UI.WebControls;
using System.Transactions.Configuration;
using System.Web.UI.HtmlControls;

namespace NestHub_BackEnd
{
    public partial class Support_Tickets : System.Web.UI.Page
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

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
            {
                connection.Open();
                using (SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM [dbo].[Ticket]", connection))
                {
                    DataTable table = new DataTable();
                    adapter.Fill(table);

                    GridView1.DataSource = table;
                    GridView1.DataBind();
                }
            }
        }
    }
}