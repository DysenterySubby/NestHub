using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOCKAirBNB
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var User = Session["User"] as User;
                if (User == null)
                    Response.Redirect("~/Stays.aspx");
                tbEmail.Value = User.Email;
                tbName.Value = User.Username;


            }
            catch (NullReferenceException)
            {
                Response.Redirect("~/Stays.aspx");
            }
        }

        protected void TicketSubmit(object sender, EventArgs e)
        {
            try
            {
                var task = Task.Run(async () =>
                {
                    using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["NestHub_db"].ConnectionString))
                    {
                        await con.OpenAsync();

                        using (var cmd = new SqlCommand("InsertTicket", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue("@Name", tbName.Value);
                            cmd.Parameters.AddWithValue("@Email", tbEmail.Value);
                            cmd.Parameters.AddWithValue("@PhoneNo", tbPhone.Value);
                            cmd.Parameters.AddWithValue("@Inquiry", tbInquiry.Value);

                            await cmd.ExecuteNonQueryAsync();
                        }
                    }
                });
                task.Wait();

                Response.Redirect("~/Stays.aspx");
            }
            catch(Exception ex)
            {
                Response.Write($"<script>alert('{ex.Message}');</script>");
            }
            
        }
    }
}