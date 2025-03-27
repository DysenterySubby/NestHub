<%@ Page Title="" Language="C#" MasterPageFile="~/NestHub.Master" AutoEventWireup="true" CodeBehind="HostPage.aspx.cs" Inherits="MOCKAirBNB.WebForm2" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container text-left">
            <asp:HiddenField ID="hfPropType" runat="server" Value="Select" />

            <div class="m-5 d-flex justify-content-around align-items-center">
                <div class="container m-3">
                    <div class="container m-1">
                        <label for="tbpropertyName" class="form-label">Property Name</label>
                        <asp:RequiredFieldValidator ID="rfvProperty" runat="server" ErrorMessage="*" ControlToValidate="tbpropertyName" ValidationGroup="HostPage" ForeColor="#dc3545"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbpropertyName" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="container m-1">
                        <label for="tbAddress" class="form-label">Address</label>
                        <asp:RequiredFieldValidator ID="rfvAdress" runat="server" ErrorMessage="*" ControlToValidate="tbAddress" ValidationGroup="HostPage" ForeColor="#dc3545"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbAddress" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="container m-1">
                        <label for="tbBarangay" class="form-label">Barangay</label>
                        <asp:RequiredFieldValidator ID="rfvBarangay" runat="server" ErrorMessage="*" ControlToValidate="tbBarangay" ValidationGroup="HostPage" ForeColor="#dc3545"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbBarangay" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="container m-1">
                        <label for="tbCity" class="form-label">City</label>
                        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="*" ControlToValidate="tbCity" ValidationGroup="HostPage" ForeColor="#dc3545"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbCity" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="container m-1">
                        <label for="tbProvince" class="form-label">Province</label>
                        <asp:RequiredFieldValidator ID="rfvProvince" runat="server" ErrorMessage="*" ControlToValidate="tbProvince" ValidationGroup="HostPage" ForeColor="#dc3545"></asp:RequiredFieldValidator>
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
                                        <li><a class="dropdown-item" onclick="updateDropdown('House')">House</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col m-1">
                            <label for="propertyType" class="form-label">Price (Per Night) </label> <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ErrorMessage="*" ControlToValidate="tbProvince" ValidationGroup="HostPage" ForeColor="#dc3545"></asp:RequiredFieldValidator>
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
                                <p class="upload-area-text"><asp:RequiredFieldValidator ID="rfvfuListing" runat="server" ErrorMessage="*" ControlToValidate="fuListing" ValidationGroup="HostPage" ForeColor="#dc3545"></asp:RequiredFieldValidator> Select images or <span>browse</span>.</p>
                            </div>
                            <asp:FileUpload ID="fuListing" runat="server" class="visually-hidden" AllowMultiple="true" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        $(document).ready(function () {
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
                       <img src = "${event.target.result}" class='upload-fixed-size-img'>
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



        function updateDropdown(selectedValue) {
            document.getElementById('proptypeBtn').innerHTML = selectedValue;
            document.getElementById("<%= hfPropType.ClientID %>").value = selectedValue;
        }
    </script>
</asp:Content>
