<%@ Page Title="Support Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Support_Tickets.aspx.cs" Inherits="NestHub_BackEnd.Support_Tickets" %>
<asp:Content ID="SupportTickets" ContentPlaceHolderID="content_body" runat="server">
    <div class = "container">
    <div class="gridview-container">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview" AutoGenerateColumns="True" DataKeyNames="TicketID" >
        </asp:GridView>
    </div>
</div>
</asp:Content>
