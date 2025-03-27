using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using MOCKAirBNB;

namespace NestHub_BackEnd
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var User = Session["User"] as User;
                if (User == null || (User.UserType != "Admin" && User.UserType != "Staff"))
                    Response.Redirect("~/Stays.aspx");
                if(User.UserType == "Staff")
                {
                    btnAdmin.Visible = false;
                }
            }
            catch (NullReferenceException)
            {
                Response.Redirect("~/Stays.aspx");
            }
        }

        protected void Signout_Event(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Stays.aspx");
        }

        protected void ChangedPage(object sender, ImageClickEventArgs e)
        {
            Session["isGoBack"] = true;
        }
    }
}