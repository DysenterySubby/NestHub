<%@ Page Title="" Language="C#" MasterPageFile="~/NestHub.Master" AutoEventWireup="true" CodeBehind="Listing.aspx.cs" Inherits="MOCKAirBNB.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfListingPrice" runat="server" />
    <main>
        <div class="container mt-5 mb-5">
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
                        <div id="listingPrice" class="m-2 p-1 fs-5">&#8369; 1000000</div>
                        <div id="listingReview" class="m-2 p-1 fs-5">&#9733; 69.420 </div>
                    </div>
                </div>
                <div class="container col">
                    <div class="container m-2">
                        <h2 id="listingName" class="fw-bold fs-2 m-0">Lorem Ipsum</h2>
                        <h2 id="listingAdd" class="fs-4 fw-medium text-secondary">Lorem Ipsum</h2>
                    </div>
                    <div class="container mt-5 mb-5 d-flex">
                        <div>
                            <img id="listingPic" src="https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png" class="rounded-circle" style="width: 80px; height: 80px;" />
                        </div>
                        <div class="container ps-2">
                            <h5 id="listingUsername" class="mb-2">Contact Host: (Skibidi Toilet)</h5>
                            <div class="ms-3 mb-1 text-secondary d-flex">
                                <div>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope me-2" viewBox="0 0 16 16">
                                        <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                                    </svg>
                                </div>
                                <div>
                                    <h6 id="listingEmail">user@nesthub.com
                                    </h6>
                                </div>
                            </div>
                            <h6 class="ms-3 mt-0 text-secondary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16">
                                    <path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" />
                                    <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
                                </svg>
                                <span id="listingContactNo">+63 987 654 3210</span>
                            </h6>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="DateUpdatePanel" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="DatePanel" runat="server">
                                <div>
                                    <div class="input-group">
                                        <div class="invalid-feedback HostError">
                                            Invalid Date.
                                        </div>
                                        <div>
                                        </div>

                                        <div class="form-floating">
                                            <asp:TextBox ID="tbCheckin" runat="server" class="form-control" type="date" placeholder="Add Date" OnTextChanged="DateChanged" AutoPostBack="True"></asp:TextBox>
                                            <label for="tbCheckin">Check in?</label>
                                        </div>
                                        <div class="form-floating">
                                            <asp:TextBox ID="tbCheckout" runat="server" class="form-control" type="date" placeholder="Drop Check Out Here" OnTextChanged="DateChanged" AutoPostBack="True"></asp:TextBox>
                                            <label for="tbCheckout">Check out</label>
                                        </div>

                                    </div>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="text-center m-4">
                            <button type="button" class="btn btn-warning btn-lg pe-5 ps-5 pt-2 pb-2 fw-bold rounded-5" data-toggle="modal" data-target="#TermsAndAgreement">Reserve</button>
                        </div>
                        <div class="modal fade" id="TermsAndAgreement" tabindex="-1" aria-labelledby="Terms" aria-hidden="true">
                            <div class="modal-dialog modal-xl">
                                <div class="modal-content bg-light">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-4 text-uppercase" id="Terms">Terms and Agreement</h1>
                                    </div>
                                    <div class="modal-body">
                                        <div class="container">
                                            <h5>1. Booking and Payment:</h5>
                                            <h6 class="m-3 fw-light"><b>1.1</b> Payment for bookings must be made in cash. We do not accept any other forms of payment.</h6>
                                            <h6 class="m-3 fw-light"><b>1.2</b> Full payment for the entire duration of your stay is required upon check-in.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>2. Security Deposit:</h5>
                                            <h6 class="m-3 fw-light"><b>2.1</b> A security deposit may be required upon check-in to cover any potential damages or restricted use of furniture.</h6>
                                            <h6 class="m-3 fw-light"><b>2.2</b> The security deposit amount will be determined by the property owner and will be refunded upon satisfactory inspection of the property at the time of check-out.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>3. Damages and Restricted Use:</h5>
                                            <h6 class="m-3 fw-light"><b>3.1</b>  Guests are responsible for any damages caused to the property, including but not limited to furniture,appliances, fixtures, and amenities.</h6>
                                            <h6 class="m-3 fw-light"><b>3.2</b> Guests must adhere to any restrictions placed on the use of furniture or amenities within the property.</h6>
                                            <h6 class="m-3 fw-light"><b>3.3</b> Any damages or restricted use will result in charges against the security deposit or additional fees as determined by the property owner.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>4. Cancellation and Refunds:</h5>
                                            <h6 class="m-3 fw-light"><b>4.1</b> Cash payments are non-refundable. In the event of a cancellation, guests will not be entitled to any refunds.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>5. Check-in and Check-out:</h5>
                                            <h6 class="m-3 fw-light"><b>5.1</b> Check-in time is [insert time], and check-out time is [insert time]. Early check-in or late check-out may be available upon request and subject to availability.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>6. Occupancy and Use:</h5>
                                            <h6 class="m-3 fw-light"><b>6.1</b> The maximum occupancy for the property is as stated in the booking details. Additional guests may not be accommodated without prior approval from the property owner.</h6>
                                            <h6 class="m-3 fw-light"><b>6.2</b> The property is to be used for residential purposes only. Any commercial or unlawful activities are strictly prohibited.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>7. Pets and Smoking:</h5>
                                            <h6 class="m-3 fw-light"><b>7.1</b> Pets are not allowed on the property unless otherwise specified and agreed upon in advance.</h6>
                                            <h6 class="m-3 fw-light"><b>7.2</b> Smoking is strictly prohibited inside the property. Guests may smoke in designated outdoor areas only.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>8. Liability:</h5>
                                            <h6 class="m-3 fw-light"><b>8.1</b> The property owner and management are not liable for any injuries, accidents, or losses that occur on the premises.</h6>
                                            <h6 class="m-3 fw-light"><b>8.2</b> Guests are responsible for their personal belongings and valuables during their stay.</h6>
                                        </div>
                                        <div class="container">
                                            <h5>9. Indemnification:</h5>
                                            <h6 class="m-3 fw-light"><b>9.1</b> Guests agree to indemnify and hold harmless the property owner and management from any claims, damages, or liabilities arising from their use of the property.</h6>
                                        </div>
                                        <div class="container pt-3 pb-3 fs-6 fw-bold">
                                            <div class="form-check form-check">
                                                <label class="form-check-label" for="btnReserve">By clicking proceed, you acknowledge that you have read, understood and agree these terms and conditions</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer container justify-content-center">
                                        <asp:Button ID="btnReserve" runat="server" Text="Proceed" class="btn btn-dark btn-lg pe-5 ps-5 pt-2 pb-2 fw-bold rounded-5" OnClick="ListingReserved" CausesValidation="true" />
                                    </div>
                                </div>    
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </main>
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
                    getListing();
                } catch (error) {
                    console.error('Error fetching data:', error);
                }
            };

            getData();

            const getListing = () => {
                const { UserNo, PropName, PropAddress, PricePerNight, PropReview, UserEmail, Username, ImgURLS, UserPic } = list_Data;
                document.getElementById('listingName').innerHTML = PropName;
                document.getElementById('listingAdd').innerHTML = PropAddress;
                document.getElementById('listingPrice').innerHTML = "&#8369; " + Number(PricePerNight).toLocaleString('en', minimumFractionDigits = 2, maximumFractionDigits = 2);
                document.getElementById('listingReview').innerHTML = `<span style="color: gold">&#9733; </span>` + PropReview;
                document.getElementById('listingEmail').innerHTML = UserEmail;
                document.getElementById('listingUsername').innerHTML = "Contact Host: " + Username;
                document.getElementById('listingContactNo').innerHTML = UserNo;
                document.getElementById("listingPic").src = UserPic;
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
            };


            const imgBtn = document.getElementById("listingPic");
            imgBtn.addEventListener("error", function (event) {
                event.target.src = "https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png";
                event.target.onerror = null;
            });

            var today = new Date();
            var month = ('0' + (today.getMonth() + 1)).slice(-2);
            var day = ('0' + today.getDate()).slice(-2);
            var year = today.getFullYear();
            var date = year + '-' + month + '-' + day;
            document.getElementById('<%=tbCheckin.ClientID%>').setAttribute('min', date);
            document.getElementById('<%=tbCheckout.ClientID%>').setAttribute('min', date);
        })

        function UpdateHostPageFields(message) {
            document.querySelector('.HostError').innerHTML = message;
            document.querySelector('.HostError').style.display = "block";
            document.getElementById('<%=tbCheckin.ClientID%>').classList.add('is-invalid');
            document.getElementById('<%=tbCheckout.ClientID%>').classList.add('is-invalid');
        }
    </script>
</asp:Content>
