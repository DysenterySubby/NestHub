﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="MOCKAirBNB.home1" Async="true"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style id="homeMain">
        .bi-person-fill {
            width: 34px;
            height: 44px;
        }

        .user-icon {
            width: 100%;
            height: 100%;
            border: 3px solid #ecc218
        }

        .bi-search {
            width: 24px;
            height: 24px;
        }

        main img {
            width: 100%;
        }
        /* HOST YOUR HOME PAGE STYLES*/
        .upload {
            background-color: var(--white-color);
            border: 1px solid gray;
            border-radius: 10px;
            box-shadow: rgba(0, 0, 0, 0.3) 0 1px 3px;
            width: 400px;
            min-height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .upload-info p {
            opacity: 0.6;
            font-weight: 600;
            margin-top: 10px;
        }

        .upload-wrapper {
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .upload-img {
            max-height: 400px;
            overflow-y: scroll;
        }

        .upload-img::-webkit-scrollbar-track {
            box-shadow: inset 0 0 6px var(--black-20-color);
            border-radius: 6px;
        }

        .upload-img::-webkit-scrollbar-thumb {
            background-color: var(--black-10-color);
            border-radius: 6px;
            background-color: #333;
        }

        .upload-img::-webkit-scrollbar {
            width: 5px;
        }

        .upload-area {
            padding: 20px;
            border: 2px dashed var(--black-20-color);
            border-radius: 8px;
            margin-top: 20px;
            cursor: pointer;
            transition: var(--transition);
        }

        .upload-area:hover {
            background-color: rgba(176, 196, 246, 0.1);
        }

        .upload-area-text {
            font-weight: 700;
            color: var(--black-50-color);
        }

        .upload-area-text span {
            color: var(--primary-color);
        }

        .visually-hidden {
            visibility: hidden;
            opacity: 0;
        }

        .upload-img {
            width: 395px;
            margin-top: 10px;
        }

        .uploaded-img {
            padding: 4px 0;
            position: relative;
        }

        /* remove image button */
        .remove-btn {
            width: 22px;
            height: 22px;
            background-color: black;
            border: 1px solid gray;
            border-radius: 50%;
            color: #ecc218;
            display: flex;
            align-items: center;
            justify-content: center;
            position: absolute;
            top: -5px;
            right: -8px;
            cursor: pointer;
            transition: var(--transition);
        }

        .remove-btn:hover {
            background-color: #ecc218;
            color: var(--white-color);
        }
    </style>
    <style id="pictureUpload">
        .profile-pic-wrapper {
            width: 100%;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .pic-holder {
            text-align: center;
            position: relative;
            border-radius: 50%;
            width: 150px;
            height: 150px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }
        .pic-holder .pic {
            height: 100%;
            width: 100%;
            -o-object-fit: cover;
            object-fit: cover;
            -o-object-position: center;
            object-position: center;
        }

        .pic-holder .upload-file-block,
        .pic-holder .upload-loader {
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
            background-color: rgba(90, 92, 105, 0.7);
            color: #f8f9fc;
            font-size: 12px;
            font-weight: 600;
            opacity: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .pic-holder .upload-file-block {
            cursor: pointer;
        }

        .pic-holder:hover .upload-file-block,
        .uploadProfileInput:focus ~ .upload-file-block {
            opacity: 1;
        }

        .pic-holder.uploadInProgress .upload-file-block {
            display: none;
        }

        .pic-holder.uploadInProgress .upload-loader {
            opacity: 1;
        }
        /* Snackbar css */
        .snackbar {
            visibility: hidden;
            min-width: 250px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            font-size: 14px;
            transform: translateX(-50%);
        }

        .snackbar.show {
            visibility: visible;
            -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
            animation: fadein 0.5s, fadeout 0.5s 2.5s;
        }

        @-webkit-keyframes fadein {
            from {
                bottom: 0;
                opacity: 0;
            }

            to {
                bottom: 30px;
                opacity: 1;
            }
        }

        @keyframes fadein {
            from {
                bottom: 0;
                opacity: 0;
            }

            to {
                bottom: 30px;
                opacity: 1;
            }
        }

        @-webkit-keyframes fadeout {
            from {
                bottom: 30px;
                opacity: 1;
            }

            to {
                bottom: 0;
                opacity: 0;
            }
        }

        @keyframes fadeout {
            from {
                bottom: 30px;
                opacity: 1;
            }

            to {
                bottom: 0;
                opacity: 0;
            }
        }

        .modal-content {
            width: 80%;
            margin: 0 auto;
        }

        .custom-modal-dialog {
            max-width: 50%;
        }
    </style>
    <style>
        .btn:focus {
          outline: none;
          box-shadow: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="isLogged" runat="server" Value="false" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark justify-content-around">
            <div>
                <a>
                    <img src="Images/Logo_NestHub_White.png" width="200" />
                </a>
            </div>
            <!-- Logo Here -->
            <div class="container d-flex flex-column w-50 m-0">
                <div class="input-group m-2">
                    <div class="form-floating">
                        <asp:TextBox ID="floatingInputValue" runat="server" class="form-control" placeholder="Drop Location Here"></asp:TextBox>
                        <label for="floatingInputValue">Where?</label>
                    </div>
                    <!-- Location Search -->
                    <div class="form-floating">
                        <input type="date" class="form-control" id="checkin" runat="server" placeholder="Add Date" />
                        <label for="checkin">Check in?</label>
                    </div>
                    <!-- Check In Search -->
                    <div class="form-floating">
                        <input type="date" class="form-control" id="checkout" runat="server" placeholder="Drop Check Out Here" />
                        <label for="checkout">Check out</label>
                    </div>
                    <!-- Amount Input -->
                    <button class="btn btn-warning">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="16"
                            height="16"
                            fill="currentColor"
                            class="bi bi-search"
                            viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
                        </svg>
                    </button>
                    <!-- Search  -->
                </div>
                <div class="custom-btn w-100">
                <div class="d-flex justify-content-evenly">
                    <div class="border-3 border-bottom border-white w-100 stays-btn">
                        <button class="btn btn-dark text-light text-uppercase fs-5 w-100" type="button" onclick="showPage('Stays')">
                            Stays
                        </button>
                    </div>

                    <div class="border-3 border-bottom border-secondary w-100 host-btn">
                        <button class="btn btn-dark text-warning text-uppercase fs-5 w-100" type="button"  onclick="showPage('HostPage')">
                            host your home
                        </button>
                    </div>
                </div>
            </div>
            </div>
            <!-- Location / Date / People Search -->
            <div>
                <div class="container">
                    <div class="dropdown">
                        <asp:ImageButton ID="btnDropDown" runat="server" ImageUrl="https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png" class="user-icon btn-warning rounded-circle"
                            data-toggle="dropdown"
                            aria-haspopup="true"
                            aria-expanded="false" Height="50px" HWidth="50px" Width="50px" />
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                            <!-- Your other dropdown items here -->
                            <div class="unauthenticated">
                                <asp:LinkButton
                                    ID="lbSignin"
                                    runat="server"
                                    class="dropdown-item"
                                    data-toggle="modal"
                                    data-target="#Login">
                              Log In
                                </asp:LinkButton>
                                <asp:LinkButton
                                    ID="lbSignup"
                                    runat="server"
                                    class="dropdown-item"
                                    data-toggle="modal"
                                    data-target="#Signup">
                              Sign Up
                                </asp:LinkButton>
                            </div>
                            <div class="authenticated">
                                <hr class="dropdown-divider" id="signoutContainer" runat="server" />
                                <asp:LinkButton
                                    ID="lbSignout"
                                    runat="server"
                                    class="dropdown-item"
                                    OnClick="Signout">
                              Sign Out
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <!-- Bootstrap Log-in -->
                    <div
                        class="modal fade"
                        id="Login"
                        tabindex="-1"
                        role="dialog"
                        aria-labelledby="popupFormLabel"
                        aria-hidden="true">
                        <div class="modal-dialog custom-modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header justify-content-center align-items-center flex-column bg-dark text-light text-center">
                                    <h6 class="text-uppercase text-warning m-3">Log In</h6>
                                    <h1 class="text-uppercase text-warning fw-bold">Access Account
                                    </h1>
                                    <h6 class="text-warning m-3">Enter your info to access your account
                                    </h6>
                                </div>
                                <asp:UpdatePanel ID="LoginUpdatePanel" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Panel ID="LoginFieldsPanel" runat="server">
                                            <div class="modal-body">
                                                <!-- Email Input Group -->
                                                <div class="mt-5 me-5 ms-5 mb-3">
                                                    <div class="form-group">
                                                        <label for="tbEmail">Email address</label>
                                                        <asp:TextBox ID="tbEmail" runat="server" class="form-control has-validation" type="email"></asp:TextBox>
                                                        <div class="invalid-feedback">
                                                            Please enter a valid email.
                                                        </div>
                                                    </div>
                                                    <!-- Password Input Group -->
                                                    <div class="form-group">
                                                        <label for="tbPassword" class="form-label">
                                                            Password</label>
                                                        <asp:TextBox ID="tbPassword" runat="server" class="form-control has-validation" type="password"></asp:TextBox>
                                                        <div class="invalid-feedback">
                                                            Please enter your password.
                                                        </div>
                                                    </div>
                                                    <div class="text-center">
                                                        <asp:Button ID="btnLogin" runat="server" Text="Login" class="btn ps-5 pe-5 btn-warning text-dark fw-bold text-uppercase" OnClick="Login" ValidationGroup="Login" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer justify-content-center align-items-center flex-column bg-dark text-light text-center">
                                                <div>
                                                    <p class="mt-3 text-center text-warning">
                                                        Don't have an account?
                                             <a
                                                 href="#"
                                                 data-toggle="modal"
                                                 data-target="#Signup"
                                                 class="text-warning">Register</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </ContentTemplate>
                                    
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <!-- Bootstrap Sign Up -->
                    <div
                        class="modal fade"
                        id="Signup"
                        tabindex="-1"
                        role="dialog"
                        aria-labelledby="popupFormLabel"
                        aria-hidden="true">
                        <div class="modal-dialog custom-modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header justify-content-center align-items-center flex-column bg-warning text-light text-center">
                                    <h6 class="text-uppercase text-dark m-3">Register</h6>
                                    <h1 class="text-uppercase text-dark">Create an Account</h1>
                                    <h6 class="text-dark m-3">enter your info below for your new account
                                    </h6>
                                </div>
                                <div class="modal-body">
                                    <!-- Your provided form content goes here -->
                                    <asp:UpdatePanel ID="RegisterUpdatePanel" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:Panel ID="RegisterFieldsPanel" runat="server">
                                                <div id="regFirst">
                                                    <div class="mt-5 me-5 ms-5 mb-3">
                                                        <div class="form-group">
                                                            <!-- Email Input Group -->
                                                            <label for="tbEmailReg">Email address</label>
                                                            <asp:RequiredFieldValidator ID="rfvEmailReg" runat="server" ErrorMessage="" ControlToValidate="tbEmailReg" ValidationGroup="Registration"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="tbEmailReg" runat="server" class="form-control has-validation" ClientIDMode="Static"></asp:TextBox>
                                                            <div class="invalid-feedback">
                                                                Please enter a valid email.
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="tbPasswordReg">Password</label>
                                                            <asp:RequiredFieldValidator ID="rfvPasswordReg" runat="server" ErrorMessage="" ControlToValidate="tbPasswordReg" ValidationGroup="Registration"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="tbPasswordReg" runat="server" class="form-control has-validation" CausesValidation="true" type="password" ClientIDMode="Static"></asp:TextBox>
                                                            <div class="invalid-feedback">
                                                                Please enter your password.
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Confirm Password</label>
                                                            <asp:RequiredFieldValidator ID="rfvPasswordConfirmReg" runat="server" ErrorMessage="" ControlToValidate="tbPasswordConfirmReg" ValidationGroup="Registration"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="tbPasswordConfirmReg" runat="server" class="form-control" CausesValidation="true" type="password" ClientIDMode="Static"></asp:TextBox>
                                                            <div class="invalid-feedback">
                                                                Please enter your password.
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="text-center">
                                                        <asp:Button ID="btnRegister" runat="server" Text="Next" class="btn ps-5 pe-5 btn-dark text-warning fw-bold text-uppercase" OnClick="Register" ValidationGroup="Registration" />
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    
                                    <div id="regSec" style="display: none">
                                        <asp:UpdatePanel ID="RegisterFields2UpdatePanel" runat="server">
                                            <ContentTemplate>
                                                <asp:Panel ID="RegisterFields2Panel" runat="server">
                                                    <div class="form-group">
                                                        <div class="profile-pic-wrapper">
                                                            <div class="pic-holder mt-3">
                                                                <!-- uploaded pic shown here -->
                                                                <img id="profilePic"
                                                                    class="pic"
                                                                    src="https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png" />
                                                                <asp:FileUpload ID="fuProfilePhoto" runat="server" class="uploadProfileInput" name="profile_pic" accept="image/*" Style="opacity: 0;" onchange="previewImage(this);" />
                                                                <label
                                                                    for="fuProfilePhoto"
                                                                    class="upload-file-block">
                                                                    <div class="text-center">
                                                                        <div class="mb-2">
                                                                            <i class="fa fa-camera fa-2x"></i>
                                                                        </div>
                                                                        <div class="text-uppercase">
                                                                            Update
                                                                            <br />
                                                                            Profile Photo
                                                                        </div>
                                                                    </div>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mt-3 me-5 ms-5 mb-3">
                                                        <div class="form-group">
                                                            <label for="tbUsernameReg">Username</label>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="" ControlToValidate="tbUsernameReg" ValidationGroup="UsernameRegistration"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="tbUsernameReg" runat="server" class="form-control" ClientIDMode="Static"></asp:TextBox>
                                                            <div class="invalid-feedback">
                                                                Enter valid username.
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="text-center">
                                                        <asp:Button ID="btnRegisterUsername" runat="server" Text="Finish" class="btn ps-5 pe-5 btn-dark text-warning fw-bold text-uppercase" OnClick="UsernameRegister" ValidationGroup="UsernameRegistration" />
                                                    </div>
                                                </asp:Panel>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:PostBackTrigger ControlID="btnRegisterUsername"/>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                                <div class="modal-footer justify-content-center align-items-center flex-column bg-warning text-light text-center">
                                    <div>
                                        <div class="progress mt-3">
                                            <div
                                                class="progress-bar bg-dark"
                                                role="progressbar"
                                                style="width: 50%"
                                                aria-valuenow="50"
                                                aria-valuemin="0"
                                                aria-valuemax="100">
                                            </div>
                                        </div>
                                        <p class="mt-3 text-center text-dark">
                                            By creating an account, you agree with our
                                    <a href="#" class="text-dark">Terms and Conditions</a>
                                            and
                                    <a href="#" class="text-dark">Privacy Statement</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <main>
            <div id="HostPage" class="container text-left" style="display: none">
                <asp:HiddenField ID="hfPropType" runat="server" Value="Select" />
                <div class="m-5 d-flex justify-content-around align-items-center">
                    <div class="container m-3">
                        <div class="container m-1">
                            <label for="tbpropertyName" class="form-label">Property Name</label>
                            <asp:RequiredFieldValidator ID="rfvProperty" runat="server" ErrorMessage="" ControlToValidate="tbpropertyName" ValidationGroup="HostPage"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="tbpropertyName" runat="server" class="form-control"></asp:TextBox>
                        </div>
                        <div class="container m-1">
                            <label for="tbAddress" class="form-label">Address</label>
                            <asp:RequiredFieldValidator ID="rfvAdress" runat="server" ErrorMessage="" ControlToValidate="tbAddress" ValidationGroup="HostPage"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="tbAddress" runat="server" class="form-control"></asp:TextBox>
                        </div>
                        <div class="container m-1">
                            <label for="tbBarangay" class="form-label">Barangay (Optional)</label>
                            <asp:RequiredFieldValidator ID="rfvBarangay" runat="server" ErrorMessage="" ControlToValidate="tbBarangay" ValidationGroup="HostPage"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="tbBarangay" runat="server" class="form-control"></asp:TextBox>
                        </div>
                        <div class="container m-1">
                            <label for="tbCity" class="form-label">City</label>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="" ControlToValidate="tbCity" ValidationGroup="HostPage"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="tbCity" runat="server" class="form-control"></asp:TextBox>
                        </div>
                        <div class="container m-1">
                            <label for="tbProvince" class="form-label">Province</label>
                            <asp:RequiredFieldValidator ID="rfvProvince" runat="server" ErrorMessage="" ControlToValidate="tbProvince" ValidationGroup="HostPage"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="tbProvince" runat="server" class="form-control"></asp:TextBox>
                        </div>

                        <div class="row m-1">
                            <div class="col m-1">
                                <label for="propertyType" class="form-label">Property Type</label>
                                <div>
                                    <div class="dropdown">
                                        <button id="proptypeBtn" class="container btn btn-secondary dropdown-toggle " type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Select
                                        </button>
                                        <ul class="container dropdown-menu dropdown-menu-secondary">
                                            <li><a class="dropdown-item" onclick="updateDropdown('Room')">Room</a></li>
                                            <li><a class="dropdown-item" onclick="updateDropdown('Condominium')">Condominium</a></li>
                                            <li><a class="dropdown-item"onclick="updateDropdown('House')">House</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="col m-1">
                                <label for="propertyType" class="form-label">Price (Per Night)</label>
                                <div class="input-group mb-3">
                                    <span class="input-group-text" id="basic-addon1">&#8369;</span>
                                    <asp:TextBox ID="tbPrice" runat="server" class="form-control" ReadOnly="False" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="container m-1 text-center">
                            <asp:Button ID="btnHost" runat="server" Text="Host your Home" class="btn btn-warning btn-lg pe-5 ps-5 pt-2 pb-2 fw-medium rounded-5  text-uppercase" OnClick="UploadListing" ValidationGroup="HostPage" />
                        </div>
                    </div>
                    <div class="container m-3">
                        <div class="container upload d-flex align-items-center justify-content-center">
                            <div class="upload-wrapper">
                                <div class="upload-img">
                                    <!-- image here -->
                                </div>
                                <div class="upload-info">
                                    <p>
                                        <span class="upload-info-value">0</span> file(s) uploaded.
                                    </p>
                                </div>
                                <div class="upload-area">
                                    <div class="upload-area-img">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="85" height="85" fill="currentColor" class="bi bi-cloud-upload" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M4.406 1.342A5.53 5.53 0 0 1 8 0c2.69 0 4.923 2 5.166 4.579C14.758 4.804 16 6.137 16 7.773 16 9.569 14.502 11 12.687 11H10a.5.5 0 0 1 0-1h2.688C13.979 10 15 8.988 15 7.773c0-1.216-1.02-2.228-2.313-2.228h-.5v-.5C12.188 2.825 10.328 1 8 1a4.53 4.53 0 0 0-2.941 1.1c-.757.652-1.153 1.438-1.153 2.055v.448l-.445.049C2.064 4.805 1 5.952 1 7.318 1 8.785 2.23 10 3.781 10H6a.5.5 0 0 1 0 1H3.781C1.708 11 0 9.366 0 7.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383" />
                                            <path fill-rule="evenodd" d="M7.646 4.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V14.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708z" />
                                        </svg>
                                    </div>
                                    <p class="upload-area-text">Select images or <span>browse</span>.</p>
                                </div>
                                <asp:FileUpload ID="fuListing" runat="server" class="visually-hidden" AllowMultiple="true" /><asp:RequiredFieldValidator ID="rfvfuListing" runat="server" ErrorMessage="" ControlToValidate="fuListing" ValidationGroup="HostPage"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="Stays" class="m-3" style="display: block">
                <div class="container">
                    <div class="card-group">
                    </div>
                </div>
            </div>
            <div id="Listing" class="container mt-5 mb-5" style="display:none;">
                <asp:HiddenField ID="hfListing" runat="server" OnValueChanged="UpdateSelectedListing" />
                <div class="row m-3">
                    <div class="container col">
                        <div id="carouselExampleIndicators" class="carousel slide">
                            <div class="carousel-indicators">
                                
                            </div>
                            <div class="carousel-inner">

                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>

                        <div class="d-flex justify-content-between">
                            <div id="listingPrice" class="border border-1 m-2 p-1 fs-5">&#8369; 1000000</div>
                            <div id="listingReview" class="border border-1 m-2 p-1 fs-5">&#9733; 69.420 </div>
                        </div>
                    </div>
                    <div class="container col">
                        <div class="container m-2">
                            <h2 id="listingName" class="fw-bold fs-2 m-0">Lorem Ipsum</h2>
                            <h2 id="listingAdd" class="fs-4 fw-medium text-secondary">Lorem Ipsum</h2>
                        </div>
                        <div class="container mt-5 mb-5 d-flex">
                            <div>
                                <img src="https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png" style="width: 80px; height: 80px;"/>
                            </div>
                            <div class="container ps-2">
                                <h5 class="mb-2">Contact Host: (Skibidi Toilet)</h5>
                                <h6 class="ms-3 mb-1 text-secondary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                                        <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                                    </svg>
                                    user@nesthub.com
                                </h6>
                                <h6 class="ms-3 mt-0 text-secondary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16">
                                        <path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" />
                                        <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
                                    </svg>
                                    +63 987 654 3210
                                </h6>
                            </div>
                        </div>
                        <div>
                            <div class="input-group">
                                <div class="form-floating">
                                    <input type="date"
                                           class="form-control"
                                           id="reserveChecking"
                                           placeholder="Add Date" />
                                    <label for="checkin">Check in?</label>
                                </div>

                                <div class="form-floating">
                                    <input type="date"
                                           class="form-control"
                                           id="reserveCheckout"
                                           placeholder="Drop Check Out Here" />
                                    <label for="checkout">Check out</label>
                                </div>
                            </div>
                        </div>

                        <div class="text-center m-4">
                            <button class="btn btn-warning btn-lg pe-5 ps-5 pt-2 pb-2 fw-bold rounded-5">
                                Reserve
                            </button>
                        </div>

                    </div>
                </div>
            </div>

        </main>
        <footer
            class="bg-dark p-3">

            <div class="row m-3">
                <div class="col-md-4 text-light d-flex justify-content-center align-items-center">
                    <div>
                        <img src="Images/Logo_NestHub_White.png" width="300" />
                    </div>
                </div>

                <div class="col-md-3 text-light">
                    <div>
                        <h4>Contact Us:</h4>

                        <p class="text-warning">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                                <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                            </svg>
                            user@nesthub.com
                        </p>
                        <p class="text-warning">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16">
                                <path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" />
                                <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
                            </svg>
                            +63 987 654 3210
                        </p>
                    </div>

                    <div>
                        <h4>Follow Us:</h4>
                        <button class="text-warning bg-transparent border-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-facebook m-1" viewBox="0 0 16 16">
                                <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951" />
                            </svg>
                        </button>

                        <button class="text-warning bg-transparent border-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-instagram m-1" viewBox="0 0 16 16">
                                <path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.9 3.9 0 0 0-1.417.923A3.9 3.9 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.9 3.9 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.9 3.9 0 0 0-.923-1.417A3.9 3.9 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599s.453.546.598.92c.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.5 2.5 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.5 2.5 0 0 1-.92-.598 2.5 2.5 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233s.008-2.388.046-3.231c.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92s.546-.453.92-.598c.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92m-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217m0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334" />
                            </svg>
                        </button>

                        <button class="text-warning bg-transparent border-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-twitter-x m-1" viewBox="0 0 16 16">
                                <path d="M12.6.75h2.454l-5.36 6.142L16 15.25h-4.937l-3.867-5.07-4.425 5.07H.316l5.733-6.57L0 .75h5.063l3.495 4.633L12.601.75Zm-.86 13.028h1.36L4.323 2.145H2.865z" />
                            </svg>
                        </button>

                        <button class="text-warning bg-transparent border-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-whatsapp m-1" viewBox="0 0 16 16">
                                <path d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232" />
                            </svg>
                        </button>

                        <button class="text-warning bg-transparent border-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-tiktok m-1" viewBox="0 0 16 16">
                                <path d="M9 0h1.98c.144.715.54 1.617 1.235 2.512C12.895 3.389 13.797 4 15 4v2c-1.753 0-3.07-.814-4-1.829V11a5 5 0 1 1-5-5v2a3 3 0 1 0 3 3z" />
                            </svg>
                        </button>

                    </div>
                </div>

                <div class="col-md-4 text-light">
                    <h4>Disclaimer:</h4>
                    <p>
                        This website is a project for IT114L / CS107L. Content is for educational / presentation purposes only.
                    </p>
                </div>

            </div>

        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>                   
            $(document).ready(function () {
                const imageListHTML = document.querySelector('.carousel-inner');
                const carouselBtnHTML = document.querySelector('.carousel-indicators');
                let list_Data = [];

                const getData = async () => {
                    try {
                        const response = await fetch('/Data/listing.json?' + new Date().getTime());
                        const data = await response.json();
                        list_Data = data;
                        console.log(list_Data.PropID);
                        console.log('<%=hfListing.Value%>')
                        getListing();
                    } catch (error) {
                        console.error('Error fetching data:', error);
                    }
                };

                getData();

                const getListing = () => {
                    const hfListing = document.getElementById('<%=hfListing.ClientID%>');
                    if (hfListing.value !== "") {
                        document.getElementById('Stays').style.display = "none";
                        document.getElementById('Listing').style.display = "block";
                        
                        const { PropName, PropAddLine, PricePerNight, PropReview, ImgURLS } = list_Data;

                        document.getElementById('listingName').innerHTML = PropName;
                        document.getElementById('listingAdd').innerHTML = PropAddLine;
                        document.getElementById('listingPrice').innerHTML = PricePerNight;
                        document.getElementById('listingReview').innerHTML = PropReview;

                        let count = 1;
                        for (const [key, value] of Object.entries(ImgURLS)) {
                            const newCarouselItem = document.createElement('div');
                            const newCarouselBtn = document.createElement('button');
                            newCarouselBtn.setAttribute('type', 'button');
                            newCarouselBtn.setAttribute('data-bs-target', '#carouselExampleIndicators');
                            newCarouselBtn.setAttribute('data-bs-slide-to', `${count - 1}`);
                            newCarouselBtn.setAttribute('aria-label', `Slide ${count}`);
                            if (count === 1) {
                                newCarouselItem.classList.add('carousel-item', 'active');
                                newCarouselBtn.classList.add('active');
                            } else {
                                newCarouselItem.classList.add('carousel-item');
                            }
                            newCarouselItem.innerHTML = `<img src="${value}" class="rounded-3" style="width: 740px; height: 500px;"/>`;
                            carouselBtnHTML.appendChild(newCarouselBtn);
                            imageListHTML.appendChild(newCarouselItem);
                            count++;
                            
                        }
                        
                    }
                };

                $("#Signup").on('hide.bs.modal', function () {
                    $("#<%= tbUsernameReg.ClientID %>").val("");
                    $("#<%= tbEmailReg.ClientID %>").val("");
                    $("#<%= tbPasswordReg.ClientID %>").val("");
                    $("#<%= tbPasswordConfirmReg.ClientID %>").val("");
                    $("#regFirst").css("display", "block");
                    $("#regSec").css("display", "none");
                });
                
                let listProductHTML = document.querySelector('.card-group');
                products = [];
                const addDataToHTML = () => {
                    // Remove data's default from HTML
                    // Add new data
                    if (products.length > 0) { // if has data
                        // Create a row to contain the cards
                        let row = document.createElement('div');
                        row.classList.add('row');

                        products.forEach(product => {
                            // Create a Bootstrap card element with grid classes
                            let newProduct = document.createElement('div');
                            newProduct.classList.add('col-md-3', 'mb-4'); // Adjust col-md-* based on your design

                            // Set the data-id attribute
                            newProduct.dataset.id = product.id;

                            // Set the inner HTML of the card
                            newProduct.innerHTML =
                                `
                                <button id="${product.PropID}" style="display: none;" type="button" onclick="showListing(this)">Hidden Button</button>
                                <label for="${product.PropID}" class="card border-0 rounded-0 btn">
                                   
                                   <img src="${product.PropImgUrl}" class="card-img-top border-0 rounded-0" alt="..." style="300px; height: 150px; object-fit: scale-down; background-color: lightgray;">
                                   <div class="card-body p-0">
                                       <h5 class="card-title m-0 text-left">${product.PropName}</h5>
                                       <h6 class="card-text m-0 text-secondary text-left">${product.PropAddLine}</h6>
                                       <div class="d-flex justify-content-between"> 
                                           <div>
                                               <h5 class="mt-3">&#8369;${product.PricePerNight}</h5>
                                           </div>
                                           <div> 
                                               <h5 class="mt-3">&#9733; ${product.PropReview}</h5>
                                           </div>
                                       </div>
                                   </div>
                               </label>`;

                            // Append the card to the row
                            row.appendChild(newProduct);
                        });

                        // Append the row to the container (listProductHTML)
                        listProductHTML.appendChild(row);
                    }
                };
                const initApp = () => {
                    // get data product
                    fetch('/Images/test.json')
                        .then(response => response.json())
                        .then(data => {
                            products = data;
                            addDataToHTML();

                        })
                }
                initApp();

                // Displays or Hide UI Elements depending if user is logged in or not
                var authenticatedElements = document.querySelectorAll(".authenticated");
                var unauthenticatedElements = document.querySelectorAll(".unauthenticated");
                var user = document.getElementById('<%= isLogged.ClientID %>').value;

                if (user !== "") {
                    authenticatedElements.forEach(function (element) {
                        element.style.display = "block";
                        document.getElementById('<%= btnDropDown.ClientID %>').src = user;
                    });
                    unauthenticatedElements.forEach(function (element) {
                        element.style.display = "none";
                    });
                    console.log("TRUE");
                } else {
                    authenticatedElements.forEach(function (element) {
                        document.getElementById('<%= btnDropDown.ClientID %>').src = "https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png";
                        element.style.display = "none";
                    });
                    unauthenticatedElements.forEach(function (element) {
                        element.style.display = "block";
                    });
                }

                const imgBtn = document.getElementById("<%= btnDropDown.ClientID %>");
                imgBtn.addEventListener("error", function (event) {
                    event.target.src = "https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png";
                    event.target.onerror = null;
                });

                var fileInput = '#' + '<%=fuListing.ClientID%>'
                $(".upload-area").click(function () {
                    $(fileInput).trigger('click');
                });

                $(fileInput).change(event => {
                    if (event.target.files) {
                        let filesAmount = event.target.files.length;
                        $('.upload-img').html("");

                        for (let i = 0; i < filesAmount; i++) {
                            let reader = new FileReader();
                            reader.onload = function (event) {
                                let html = `
                                   <div class = "uploaded-img">
                                       <img src = "${event.target.result}">
                                       <button type = "button" class = "remove-btn">
                                           <i class = "fas fa-times"></i>
                                       </button>
                                   </div>
                               `;
                                $(".upload-img").append(html);
                            }
                            reader.readAsDataURL(event.target.files[i]);
                        }

                        $('.upload-info-value').text(filesAmount);
                        $('.upload-img').css('padding', "20px");
                    }
                });

                $(window).click(function (event) {
                    if ($(event.target).hasClass('remove-btn')) {
                        $(event.target).parent().remove();
                    } else if ($(event.target).parent().hasClass('remove-btn')) {
                        $(event.target).parent().parent().remove();
                    }
                })

            });
            function previewImage(input) {
                var file = input.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var image = document.getElementById('profilePic');
                        image.src = e.target.result;
                    };

                    reader.readAsDataURL(file);
                }
            }

            function showPage(page) {
                var user = document.getElementById('<%= isLogged.ClientID %>').value;
                var hostBtn = document.querySelector('.host-btn');
                var staysBtn = document.querySelector('.stays-btn');
                if (page === 'HostPage') {
                    if (user !== "") {
                        hostBtn.classList.remove('border-secondary');
                        hostBtn.classList.add('border-white');
                        staysBtn.classList.remove('border-white');
                        staysBtn.classList.add('border-secondary');
                        document.getElementById(page).style.display = "block";
                        document.getElementById('Listing').style.display = "none";
                        document.getElementById('Stays').style.display = "none";
                    }
                    else {
                        $("#Login").modal('show');
                    }
                }
                else {
                    staysBtn.classList.remove('border-secondary');
                    staysBtn.classList.add('border-white');
                    hostBtn.classList.remove('border-white');
                    hostBtn.classList.add('border-secondary');
                    document.getElementById(page).style.display = "block";
                    document.getElementById('HostPage').style.display = "none";
                    document.getElementById('Listing').style.display = "none";
                }
            }

            function showListing(button) {
                document.getElementById('<%=hfListing.ClientID%>').value = button.id;
                __doPostBack();
            }
        </script>
        <script type="text/javascript">
            function updateDropdown(selectedValue) {
                document.getElementById('proptypeBtn').innerHTML = selectedValue;
                document.getElementById("<%= hfPropType.ClientID %>").value = selectedValue;
            }
        </script>
    </form>
</body>
</html>
