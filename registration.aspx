<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registration.aspx.cs" Inherits="MOCKAirBNB.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NestHub: Register</title>
    <link rel="stylesheet" href="CSS/style.css" />
    
</head>
<body>
    <header>
        <form id="form1" runat="server">
            <div>
                <h1>Registration</h1>
                <p>
                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                </p>
            <div class="Email-container login-contents">
              <h3>Email address
                  <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbEmail" ErrorMessage="*" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                </h3>
                <asp:TextBox ID="tbEmail" runat="server" type="email" CssClass="txtbox"></asp:TextBox>
            </div>
              <br />
              <p class="grey">Use a minimum of 10 characters, including letters, lowercase letters, and numbers.</p>
            <div class="password-container login-contents">
              <h3>Password
                  <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="tbPassword" ErrorMessage="*" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                </h3>
              <asp:TextBox ID="tbPassword" runat="server" type="password" CssClass="txtbox"></asp:TextBox>
            </div>
            <div class="password-container login-contents">
              <h3>Confirm Password
                  <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="tbConfirmPassword" ErrorMessage="*" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                </h3>
              <asp:TextBox ID="tbConfirmPassword" runat="server" type="password" CssClass="txtbox"></asp:TextBox>
            </div>
            </div>
            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="submit" OnClick="Register"/>
              <p class="auto-style1"><span class="auto-style3">By creating an account, you agree with our </span><span class="auto-style2">Terms and Conditions</span><span class="auto-style3"> and </span><span class="auto-style2">Privacy Statement</span>.</p>
        </form>
    </header>
    
</body>
</html>