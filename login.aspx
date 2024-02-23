<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="MOCKAirBNB.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NestHub</title>
    <link rel="stylesheet" href="CSS/style.css" />
</head>
<body>
    <header>
        <form id="form1" runat="server">
        <h1>Sign in</h1>
        <div class="Email-container login-contents">
            <h3>Email address</h3>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="txtbox" type="email"></asp:TextBox>
        </div>
        <div class="password-container login-contents">
            <h3>Password</h3>
            <asp:TextBox ID="TextBox2" runat="server" CssClass="txtbox" type="password"></asp:TextBox>
        </div>
        <div class="option login-contents">
            <div class="Left-side">
                <asp:CheckBox ID="CheckBox1" runat="server" CssClass="check-box" type="checkbox"/>
                <label for="Remember">Keep me Signed In</label>
            </div>
            <div class="right-side">
                <a href="#">Forgot Password?</a>
            </div>
        </div>
            <asp:Button ID="Button1" runat="server" Text="Continue with email" CssClass="submit"/>
            <p>Don't have an account? <a href="#">Register!!!!</a></p>
        </form>
    </header>
</body>
</html>
