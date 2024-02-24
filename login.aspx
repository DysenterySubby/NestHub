<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="MOCKAirBNB.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NestHub</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
</head>
<body>
    <header>
        <form id="form1" runat="server">
        <h1>Sign in</h1>
            <p>
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </p>
            <asp:Label ID="Label1" runat="server"></asp:Label>
        <div class="Email-container login-contents">
            <h3>Email address</h3>
            <asp:TextBox ID="tbEmail" runat="server" CssClass="txtbox" type="email"></asp:TextBox>
        </div>
        <div class="password-container login-contents">
            <h3>Password</h3>
            <asp:TextBox ID="tbPassword" runat="server" CssClass="txtbox" type="password"></asp:TextBox>
        </div>
        <div class="option login-contents">
            <div class="Left-side">
                <asp:CheckBox ID="cbKeepLogin" runat="server" CssClass="check-box" type="checkbox" OnCheckedChanged="KeepLogin_Changed"/>
                <label for="Remember">Keep me Signed In</label>
            </div>
            <div class="right-side">
                <a href="#">Forgot Password?</a>
            </div>
        </div>
            <asp:Button ID="btnLogin" runat="server" Text="Continue with email" CssClass="submit" OnClick="Login"/>
            <p>Don't have an account? <a href="registration.aspx">Register</a></p>
        </form>
    </header>
</body>
</html>
