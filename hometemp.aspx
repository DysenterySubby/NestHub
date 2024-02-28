<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hometemp.aspx.cs" Inherits="MOCKAirBNB.home" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="CSS/home-design.css"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <nav>
             <div class="container mt-5">
               <div class="dropdown">
                 <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                   <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                     <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                   </svg>
                 </button>
                   <asp:Label runat="server" Text="Label" ID="lbltester"></asp:Label>
                   
                 <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                   <!-- Your other dropdown items here -->
                   <a class="dropdown-item" href="#" data-toggle="modal" data-target="#Login">Log In</a>
                   <a class="dropdown-item" href="#" data-toggle="modal" data-target="#Signup">Sign Up</a>
                   <hr class="dropdown-divider"/>
                   <a class="dropdown-item" href="#" data-toggle="modal" data-target="#">Sign Out</a>
                 </div>
               </div>
            </div>
             <!-- Bootstrap Log-in -->
             <div class="modal fade" id="Login" tabindex="-1" role="dialog" aria-labelledby="popupFormLabel" aria-hidden="true">
               <div class="modal-dialog" role="document">
                 <div class="modal-content">
                   <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                       <span aria-hidden="true">&times;</span>
                     </button>
                   </div>
                   <div class="modal-body">
                     <!-- Your provided form content goes here -->
                       <h1 class="mb-4 text-center text-dark">Log In</h1>
                       <!-- Email Input Group -->
                       <div class="form-group">
                         <label>Email address</label>
                           <asp:TextBox ID="tbEmail" runat="server" type="email" CssClass="form-control"></asp:TextBox>
                         <div class="invalid-feedback">
                           Please enter a valid email.
                         </div>
                       </div>
                       <!-- Password Input Group -->
                       <div class="form-group">
                         <label class="form-label">Password</label>
                           <asp:TextBox ID="tbPassword" runat="server" CssClass="form-control" type="password"></asp:TextBox>
                         <div class="invalid-feedback">
                           Please enter your password.
                         </div>
                       </div>
                       <div class="form-group form-check d-flex justify-content-between">
                           <asp:CheckBox ID="cbKeepLogin" runat="server" CssClass="form-check-input" type="checkbox" OnCheckedChanged="KeepLogin_Changed"/>
                         <label class="form-check-label" for="Remember" >Keep me Signed In</label>
                         <a href="#" class="d-block mb-3" >Forgot Password?</a>
                       </div>
                         <asp:Button ID="btnLogin" runat="server" Text="Continue with email" CssClass="btn btn-primary btn-block" OnClick="Login" ValidationGroup="LoginValidation" />
                       <p class="mt-3 text-center">Don't have an account?<a href="#">Register</a></p>
                   </div>
                 </div>
               </div>
             </div>
            <!-- Bootstrap Sign Up -->
             <div class="modal fade" id="Signup" tabindex="-1" role="dialog" aria-labelledby="popupFormLabel" aria-hidden="true">
               <div class="modal-dialog" role="document">
                 <div class="modal-content">
                   <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                       <span aria-hidden="true">&times;</span>
                     </button>
                   </div>
                   <div class="modal-body">
                     <!-- Your provided form content goes here -->
                       <h1 class="mb-4 text-center text-dark">Sign Up</h1>
                       <div class="form-group">
                         <!-- Email Input Group -->
                         <label>Email address <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbRegEmail" ErrorMessage="*" ForeColor="#CC3300" ValidationGroup="RegisterValidation"></asp:RequiredFieldValidator></label>
                           <asp:TextBox ID="tbRegEmail" runat="server" type="email" CssClass="form-control"></asp:TextBox>
                         <div class="invalid-feedback">
                           Please enter a valid email.
                         </div>
                       </div>
                       <div class="form-group">
                         <label>Password <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="tbRegPassword" ErrorMessage="*" ForeColor="#CC3300" ValidationGroup="RegisterValidation"></asp:RequiredFieldValidator></label>
                           <asp:TextBox ID="tbRegPassword" runat="server" type="password" CssClass="form-control"></asp:TextBox>
                         <div class="invalid-feedback">
                           Please enter your password.
                         </div>
                       </div>
                       <div class="form-group">
                         <label>Confirm Password <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="tbRegConfirmPassword" ErrorMessage="*" ForeColor="#CC3300" ValidationGroup="RegisterValidation"></asp:RequiredFieldValidator></label>
                           <asp:TextBox ID="tbRegConfirmPassword" runat="server" type="password" CssClass="form-control" ></asp:TextBox>
                         <div class="invalid-feedback">
                           Please enter your password.
                         </div>
                       </div>
                       <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-primary btn-block" OnClick="Register" ValidationGroup="RegisterValidation"/>
                       <p class="mt-3 text-center">By creating an account, you agree with our <a href="#">Terms and Conditions</a> and <a href="#">Privacy Statement</a></p>
                   </div>
                 </div>
               </div>
             </div>
            <!-- Bootstrap Sign Up USERNAME -->
            <div class="modal fade" id="SignupUsername" tabindex="-1" role="dialog" aria-labelledby="popupFormLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    <!-- Your provided form content goes here -->
                      <div class="profile-pic-wrapper">
                          <h1 class="h1">Account Registered</h1>
                          <div class="pic-holder">
                            <!-- uploaded pic shown here -->
                            <img id="profilePic"  class="pic" src="https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"/>
                              <asp:FileUpload ID="newProfilePhoto" runat="server" CssClass ="uploadProfileInput" class="uploadProfileInput" name="profile_pic" accept="image/*" style="opacity: 0;" onchange="previewImage(this);"/>
                                <label for="newProfilePhoto" class="upload-file-block">
                                    <div class="text-center">
                                        <div class="mb-2">
                                            <i class="fa fa-camera fa-2x"></i>
                                        </div>
                                        <div class="text-uppercase">
                                            Update <br /> Profile Photo
                                        </div>
                                    </div>
                                </label>
                            </div>
                        </div>
                      <div class="form-group">
                        <label> Username<asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="tbUsername" ErrorMessage="*" ForeColor="#CC3300" ValidationGroup="RegisterUsernameValidation"></asp:RequiredFieldValidator></label>
                          <asp:TextBox ID="tbUsername" runat="server" CssClass="form-control"></asp:TextBox>
                      </div>
                        <asp:Button ID="btnRegistrationUsername" runat="server" Text="Finish Registration" CssClass="btn btn-primary btn-block" OnClick="UsernameRegister" ValidationGroup="RegisterUsernameValidation"/>
                      <p class="mt-3 text-center">By creating an account, you agree with our <a href="#">Terms and Conditions</a> and <a href="#">Privacy Statement</a></p>
                  </div>
                </div>
              </div>
            </div>
             <!-- Bootstrap JS and Popper.js -->
             <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
             <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
             <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
             <script type="text/javascript" src="/JS/register.js"></script>
        </nav>
        <header>
                <div class="img-container">
                    <img src="Images/background-img.jpg" />
                    <div class="img-text-container">
                        <h1>Enjoy Your Dream Vacation</h1>
                        <p>&nbsp;</p>
                        <h6>Plan and book our perfect trip with expert advice, travel tips, destination information and inspiration from us.</h6>
                    </div>
                    <div class="search-container">
                        <select name="location" id="location" class="search-contents">
                            <option value="none">Where are you going?</option>
                            <option value="Laguna">Laguna</option>
                            <option value="Cavite">Cavite</option>
                            <option value="Muntinlupa">Muntinlupa</option>
                            <option value="Calamba">Calamba</option>
                            <option value="Manila">Manila</option>
                        </select>
                        <input type="date" id="start-trip" name="start-trip" class="search-contents"/>
                        <input type="date" id="end-trip" name="end-trip" class="search-contents"/>
                        <button class="search-button search-contents">Search</button>
                    </div>
                </div>
            <div class="img-container">&nbsp;</div>
        </header>
        <footer>
            <div class="footer-container">
                <h2>Something Something</h2>
                <h4>Something Something</h4>
            </div>
            <div class="footer-container">
                <h3>Company</h3>
                <a href="#">About</a>
                <a href="#">Advertising</a>
                <a href="#">Contact is</a>
            </div>
            <div class="footer-container">
                <h3>Terms and Policies</h3>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of use</a>
                <a href="#">Acessibility</a>
                <a href="#">Reward system policy</a>
            </div>
            <div class="footer-container">
                <h3>Help</h3>
                <a href="#">Support</a>
                <a href="#">Cancel your bookings</a>
                <a href="#">Use Coupon</a>
                <a href="#">Refund Policies</a>
                <a href="#">International Travel Documents</a>
            </div>
        </footer>
    </form>
</body>
</html>
