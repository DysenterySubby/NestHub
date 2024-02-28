<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="MOCKAirBNB.home1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <style id="homeMain">
        .bi-person-fill {
        width: 34px;
        height: 44px;
        }

        .bi-search{
        width: 24px;
        height: 24px;
        }
    </style>
    <style id="pictureUpload">
        .profile-pic-wrapper {
          height: 100vh;
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

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark justify-content-around">
          <div>
            <a href="#">
              <img src="img-folder/Logo-img(1).png" width="200" height="auto" />
            </a>
          </div> <!-- Logo Here -->
          <div>
        <div class="input-group m-2">
          <div class="form-floating">
              <asp:TextBox ID="floatingInputValue" runat="server" class="form-control" placeholder="Drop Location Here"></asp:TextBox>
            <label for="floatingInputValue">Where?</label>
          </div> <!-- Location Search -->

          <div class="form-floating">
              <input type="date" class="form-control" id="checkin" runat="server" placeholder="Add Date" />
            <label for="checkin">Check in?</label>
          </div> <!-- Check In Search -->

          <div class="form-floating">
            <input type="date" class="form-control" id="checkout" runat="server" placeholder="Drop Check Out Here" />
            <label for="checkout">Check out</label>
          </div> <!-- Check Out Search -->

          <div class="form-floating">
              <asp:TextBox ID="guest" runat="server" class="form-control" placeholder="Drop guest Here"></asp:TextBox>
            <label for="guest">Who?</label>
          </div> <!-- Amount Input -->

          <button class="btn btn-warning">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              fill="currentColor"
              class="bi bi-search"
              viewBox="0 0 16 16">
              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
            </svg>
          </button> <!-- Search  -->
        </div>

            <div class="container d-flex justify-content-around align-items-center">

              <div class="dropdown">
                <button class="btn btn-dark p-2 text-uppercase" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                  stays
                </button>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">Action</a></li>
                  <li><a class="dropdown-item" href="#">Another action</a></li>
                  <li><a class="dropdown-item" href="#">Something else here</a></li>
                </ul>
              </div>

              <div class="vr bg-white"></div>

              <div class="dropdown">
                <button class="btn btn-dark text-uppercase" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                  experiences
                </button>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">Action</a></li>
                  <li><a class="dropdown-item" href="#">Another action</a></li>
                  <li><a class="dropdown-item" href="#">Something else here</a></li>
                </ul>
              </div>

              <div class="vr bg-white"></div>

              <div class="dropdown">
                <button class="btn btn-dark text-warning text-uppercase" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                  host your home
                </button>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">Action</a></li>
                  <li><a class="dropdown-item" href="#">Another action</a></li>
                  <li><a class="dropdown-item" href="#">Something else here</a></li>
                </ul>
              </div>
            </div>
    
          </div> <!-- Location / Date / People Search -->

          <div>
            <div class="container">
              <div class="dropdown">
                <button
                  class="btn btn-warning rounded-circle"
                  type="button"
                  id="dropdownMenuButton"
                  data-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="16"
                    height="16"
                    fill="currentColor"
                    class="bi bi-person-fill"
                    viewBox="0 0 16 16"
                  >
                    <path
                      d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"
                    />
                  </svg>
                </button>

                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                  <!-- Your other dropdown items here -->
                  <a
                    class="dropdown-item"
                    href="#"
                    data-toggle="modal"
                    data-target="#Login"
                    >Log In</a
                  >
                  <a
                    class="dropdown-item"
                    href="#"
                    data-toggle="modal"
                    data-target="#Signup"
                    >Sign Up</a
                  >
                  <li><hr class="dropdown-divider" /></li>
                  <a
                    class="dropdown-item"
                    href="#"
                    data-toggle="modal"
                    data-target="#"
                    >Sign Out</a
                  >
                </div>
              </div>

              <!-- Bootstrap Log-in -->
              <div
                class="modal fade"
                id="Login"
                tabindex="-1"
                role="dialog"
                aria-labelledby="popupFormLabel"
                aria-hidden="true"
              >
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                      >
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>

                    <div class="modal-body">
                      <div action="#" class="needs-validation" novalidate>
                        <h1 class="mb-4 text-center">Log In</h1>

                        <!-- Email Input Group -->
                        <form class="form-group">
                          <label for="tbEmail">Email address</label>
                            <asp:TextBox ID="tbEmail" runat="server" class="form-control has-validation" type="email" required></asp:TextBox>
                          <div class="invalid-feedback">
                            Please enter a valid email.
                          </div>
                        </form>

                        <!-- Password Input Group -->
                        <div class="form-group">
                          <label for="tbPassword" class="form-label"
                            >Password</label
                          >
                            <asp:TextBox ID="tbPassword" runat="server" class="form-control has-validation" type="password" required></asp:TextBox>
                          <div class="invalid-feedback">
                            Please enter your password.
                          </div>
                        </div>

                        <div
                          class="form-group form-check d-flex justify-content-between"
                        >
                            <!-- EDIT THIS LATER RION -->
                          <input
                            type="checkbox"
                            class="form-check-input"
                            id="Remember"
                          />
                          <label for="Remember">Keep me Signed In</label>
                          <a href="#" class="d-block mb-3">Forgot Password?</a>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">
                          Continue with email
                        </button>
                        <p class="mt-3 text-center">
                          Don't have an account?
                          <a href="#" data-toggle="modal" data-target="#Signup"
                            >Register</a
                          >
                        </p>
                      </div>
                    </div>
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
                aria-hidden="true"
              >
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                      >
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>

                    <div class="modal-body">
                      <!-- Your provided form content goes here -->
                      <div action="#" class="needs-validation" novalidate>
                        <h1 class="mb-4 text-center">Sign Up</h1>
                        <div class="form-group">
                          <!-- Email Input Group -->
                          <label for="tbEmailReg">Email address</label>
                            <asp:TextBox ID="tbEmailReg" runat="server" class="form-control" type="email" required></asp:TextBox>
                          <div class="invalid-feedback">
                            Please enter a valid email.
                          </div>
                        </div>

                        <div class="form-group">
                          <label for="tbPasswordReg">Password</label>
                            <asp:TextBox ID="tbPasswordReg" runat="server" class="form-control" type="password" required></asp:TextBox>
                          <div class="invalid-feedback">
                            Please enter your password.
                          </div>
                        </div>

                        <div class="form-group">
                          <label for="inputPassword">Confirm Password</label>
                            <asp:TextBox ID="tbPasswordConfirmReg" runat="server" class="form-control" type="password" required></asp:TextBox>
                          <div class="invalid-feedback">
                            Please enter your password.
                          </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">
                          Create Account
                        </button>
                        <p class="mt-3 text-center">
                          By creating an account, you agree with our
                          <a href="#">Terms and Conditions</a> and
                          <a href="#">Privacy Statement</a>
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
                <!-- Bootstrap Sign-Up Username -->
                <div
                  class="modal fade"
                  id="SignupUsername"
                  tabindex="-1"
                  role="dialog"
                  aria-labelledby="popupFormLabel"
                  aria-hidden="true"
                >
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button
                          type="button"
                          class="close"
                          data-dismiss="modal"
                          aria-label="Close"
                        >
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>

                      <div class="modal-body">
                        <!-- Your provided form content goes here -->
                        <div action="#" class="needs-validation" novalidate>
                          <h1 class="mb-4 text-center">Sign Up</h1>
                          <div class="form-group">
                            <!-- Picture Upload Group -->
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
                            <label for="tbPasswordReg">Password</label>
                              <asp:TextBox ID="TextBox3" runat="server" class="form-control" type="password" required></asp:TextBox>
                            <div class="invalid-feedback">
                              Please enter your password.
                            </div>
                          </div>

                          <div class="form-group">
                            <label for="inputPassword">Confirm Password</label>
                              <asp:TextBox ID="TextBox4" runat="server" class="form-control" type="password" required></asp:TextBox>
                            <div class="invalid-feedback">
                              Please enter your password.
                            </div>
                          </div>

                          <button type="submit" class="btn btn-primary btn-block">
                            Create Account
                          </button>
                          <p class="mt-3 text-center">
                            By creating an account, you agree with our
                            <a href="#">Terms and Conditions</a> and
                            <a href="#">Privacy Statement</a>
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
            </div>
          </div> <!-- DropDown Menu Here -->
        </nav>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>   
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
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
        </script>
        <script>
            (() => {
                'use strict';

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                const forms = document.querySelectorAll('.needs-validation');

                // Loop over them and prevent submission
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        // Check custom validation for a hypothetical input with ID 'ValidationCustom01'
                        const customField = form.querySelector('#tbEmail');
                        if (customField.value.trim() === '') {
                            // If custom validation fails, prevent submission
                            event.preventDefault();
                            event.stopPropagation();

                            // Optionally, you can provide feedback to the user for the failed validation
                            customField.classList.add('is-invalid');
                        } else {
                            // If custom validation passes, remove any previous validation feedback
                            customField.classList.remove('is-invalid');
                        }

                        // Bootstrap validation check
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }

                        form.classList.add('was-validated');
                    }, false);
                });
            })();
        </script>
    </form>
</body>
</html>
