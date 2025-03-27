<%@ Page Title="" Language="C#" MasterPageFile="~/NestHub.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="MOCKAirBNB.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfUserPicUrl" runat="server" />
    <asp:HiddenField ID="hfUserName" runat="server" />
    <asp:HiddenField ID="hfEmail" runat="server" />
    <asp:HiddenField ID="hfListing" runat="server" OnValueChanged="SelectedListing" />
    <asp:HiddenField ID="hfRating" runat="server" OnValueChanged="SelectedRating" />
    <main class="container">
        <div class="row m-4 ">
            <div class="container col-4 col-xxl-4 col-xl-4 col-lg-4 col-md-12 col-sm-12 text-center">
                <img id="imgProfilepic" src="Images/Icon_User.png" class="mt-5 border border-0  rounded-circle" style="width: 210px; height: 200px; object-fit: cover;">
                <h1 class="mt-4 mb-4 fw-bold"><span id="spnUsername">Naull</span></h1>

                <div class="row justify-content-center">
                    <div class="col-md-7">
                        <h6 class="text-secondary m-0 text-start">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                                <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                            </svg> <span id="spnEmail">Dustin1@nesthub.com</span>
                        </h6>
                        <h6 class="text-secondary text-start">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16">
                                <path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" />
                                <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
                            </svg>+63 987 654 3210
                        </h6>
                    </div>
                </div>
            </div>
            <div class="col-8">
                <div class="m-3">
                    <h2 class="m-0">Owned Properties</h2>
                    <div class="container mt-3">
                        <div class="card-container owned-properties">
                        </div>
                    </div>
                </div>
                <div class="m-3">
                    <hr>
                </div>
                <div class="m-3">
                    <h2 class="m-0">Currently Booked In</h2>
                    <div class="container mt-3">
                        <div class="card-container booked-properties">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script>
        $(document).ready(function () {
            let cardContainerHTML = document.querySelector('.booked-properties');
            listings = [];
            const addDataToHTML = () => {
                if (listings.length > 0) { // if has data
                    // Create a row to contain the cards
                    listings.forEach(listing => {

                        let card = document.createElement('div');
                        let disableAttr = "";
                        let disableStyle = "";
                        let buttonText = "Rate"
                        card.classList.add('m-2', 'card');

                        // Set the data-id attribute
                        card.dataset.id = listing.BookingID;

                        if (listing.IsRated !== 'False') {
                            disableAttr = "disabled";
                            disableStyle = `style="display: none"`;
                            buttonText = "Rated"
                        }
                            
                        // Set the inner HTML of the card
                        card.innerHTML = `
                            <img src="${listing.PropImgUrl}" class="card-img-top" style="width: 400px; height: 250px;" >
                            <div class="card-body">
                                <div class="container d-flex justify-content-center flex-column">
                                    <div class="row align-items-center align-items-sm-end">
                                        <div class="col-5 text-center">
                                            <h5 class="fw-bold">Check In</h5>
                                            <h6 class="fw-medium text-secondary">${listing.StartDate}</h6>
                                        </div>

                                        <hr class="col-2 container border-3" style="width: 5px;">

                                        <div class="container col-5 text-center ">
                                            <h5 class="fw-bold">Check Out</h5>
                                            <h6 class="fw-medium text-secondary">${listing.EndDate}</h6>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center flex-column me-2">
                                        <fieldset class="rate" id="${listing.BookingID}" ${disableStyle}>
                                            <input type="radio" id="star5_${listing.BookingID}" name="rating_${listing.BookingID}" value="5" />
                                            <label for="star5_${listing.BookingID}">★</label>
                                            <input type="radio" id="star4_${listing.BookingID}" name="rating_${listing.BookingID}" value="4" />
                                            <label for="star4_${listing.BookingID}">★</label>
                                            <input type="radio" id="star3_${listing.BookingID}" name="rating_${listing.BookingID}" value="3" />
                                            <label for="star3_${listing.BookingID}">★</label>
                                            <input type="radio" id="star2_${listing.BookingID}" name="rating_${listing.BookingID}" value="2" />
                                            <label for="star2_${listing.BookingID}">★</label>
                                            <input type="radio" id="star1_${listing.BookingID}" name="rating_${listing.BookingID}" value="1" />
                                            <label for="star1_${listing.BookingID}">★</label>
                                        </fieldset>
                                        <button id="${listing.BookingID}" type="button" class="btn btn-warning btn-lg pe-5 ps-5 pt-2 pb-2 mt-3 fw-bold rounded-5 w-50" onclick="rateClicked(this)" ${disableAttr}>
                                            ${buttonText}
                                        </button>
                                    </div>
                                </div>
                            </div>`;
                        cardContainerHTML.appendChild(card);
                    });
                }
            };

            const initApp = () => {
                // get data product
                fetch('/Data/userbookinglist.json')
                    .then(response => response.json())
                    .then(data => {
                        listings = data;
                        addDataToHTML();

                    })
            }
            initApp();

            
        });

        function rateClicked(button) {
            const parentElement = button.parentElement;
            const selectedRating = parentElement.querySelector('input[type="radio"]:checked');

            if (selectedRating) {
                document.getElementById('<%=hfRating.ClientID%>').value = selectedRating.value + ';' + button.id;
                __doPostBack();
            } else {
                alert('Please select a rating.');
            }
        }

    </script>
    <script>
        $(document).ready(function () {
            let cardContainerHTML = document.querySelector('.owned-properties');
            listings = [];
            const addDataToHTML = () => {
                if (listings.length > 0) { // if has data
                    // Create a row to contain the cards


                    listings.forEach(listing => {

                        let card = document.createElement('div');
                        card.classList.add('m-2', 'card');

                        // Set the data-id attribute
                        card.dataset.id = listing.PropID;

                        // Set the inner HTML of the card
                        card.innerHTML =
                            `
                             <button id="${listing.PropID}" style="display: none;" type="button" onclick="showListing(this)">Hidden Button</button>
                             <label for="${listing.PropID}" class="card custom-card border-0 rounded-0 btn">
                                <img src="${listing.PropImgUrl}" class="custom-img img-fluid object-fit-cover" alt="...">
                                <div class="card-body p-0">
                                    <h5 class="card-title m-0 text-left">${listing.PropName}</h5>
                                    <h6 class="card-text m-0 text-secondary text-left">${listing.PropAddress}</h6>
                                    <div class="d-flex justify-content-between"> 
                                        <div>
                                            <h5 class="mt-3">&#8369; ${listing.PricePerNight}</h5>
                                        </div>
                                        <div> 
                                            <h5 class="mt-3"><span style="color: gold">&#9733; </span>${listing.PropReview}</h5>
                                        </div>
                                    </div>
                                </div>
                            </label>`;
                        cardContainerHTML.appendChild(card);
                    });
                }
            };


            const initApp = () => {
                // get data product
                fetch('/Data/userlistinglist.json')
                    .then(response => response.json())
                    .then(data => {
                        listings = data;
                        addDataToHTML();

                    })
            }
            initApp();

            document.getElementById("imgProfilepic").src = document.getElementById("<%=hfUserPicUrl.ClientID%>").value;
            document.getElementById("spnEmail").innerHTML = document.getElementById("<%=hfEmail.ClientID%>").value;
            document.getElementById("spnUsername").innerHTML = document.getElementById("<%=hfUserName.ClientID%>").value;

            const imgBtn = document.getElementById("imgProfilepic");
            imgBtn.addEventListener("error", function (event) {
                event.target.src = "https://nesthubstorage.blob.core.windows.net/userprofilepicture/Icon_User.png";
                event.target.onerror = null;
            });

            
        });

        function showListing(button) {
            document.getElementById('<%=hfListing.ClientID%>').value = button.id;
            __doPostBack();
        }
    </script>
</asp:Content>
