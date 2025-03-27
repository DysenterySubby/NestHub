<%@ Page Title="Staff Info" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Staff_Info.aspx.cs" Inherits="NestHub_BackEnd.Staff_Info" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content_body" runat="server">
    <div class = "container">
        <div class="gridview-container">
            <h3><asp:Label ID="Admin_Label" runat="server" Text="ADMIN:"></asp:Label></h3>
            <asp:GridView ID="Admin_Grid" runat="server" CssClass="gridview" DataKeyNames="UserID">
            </asp:GridView>
        </div>
    </div>
    <div class = "container">
        <div class="gridview-container">
            <h3><asp:Label ID="Team_Label" runat="server" Text="TEAM:"></asp:Label></h3>
            <asp:GridView ID="Team_Grid" runat="server" CssClass="gridview" DataKeyNames="UserID">
</asp:GridView>
        </div>
    </div>
</asp:Content>
