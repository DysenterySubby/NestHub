<%@ Page Title="" Language="C#" MasterPageFile="~/NestHub.Master" AutoEventWireup="true" CodeBehind="Stays.aspx.cs" Inherits="MOCKAirBNB.WebForm1" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfListing" runat="server" OnValueChanged="SelectedListing" />
    <main>
        <div class="m-3">
            <div class="container">
                <div class="card-group">
                </div>
            </div>
        </div>
    </main>
    
    <script>
        $(document).ready(function () {
            let listProductHTML = document.querySelector('.card-group');
            products = [];
            const addDataToHTML = () => {
                if (products.length > 0) { // if has data
                    // Create a row to contain the cards
                    let row = document.createElement('div');
                    row.classList.add('row', 'container');

                    products.forEach(product => {
                        // Create a Bootstrap card element with grid classes
                        let newProduct = document.createElement('div');
                        newProduct.classList.add('container', 'col-auto', 'col-xxl-3', 'col-xl-4', 'col-lg-6', 'col-md-12', 'm-0'); 

                        // Set the data-id attribute
                        newProduct.dataset.id = product.PropID;

                        // Set the inner HTML of the card
                        newProduct.innerHTML =
                            `
                            <button id="${product.PropID}" style="display: none;" type="button" onclick="showListing(this)">Hidden Button</button>
                            <label for="${product.PropID}" class="card custom-card border-0 rounded-0 btn">
                               <img src="${product.PropImgUrl}" class="custom-img img-fluid object-fit-cover" alt="...">
                               <div class="card-body p-0">
                                   <h5 class="card-title m-0 text-left">${product.PropName}</h5>
                                   <h6 class="card-text m-0 text-secondary text-left">${product.PropAddress}</h6>
                                   <div class="d-flex justify-content-between"> 
                                       <div>
                                           <h5 class="mt-3">&#8369; ${Number(product.PricePerNight).toLocaleString('en', minimumFractionDigits = 2)}</h5>
                                       </div>
                                       <div> 
                                           <h5 class="mt-3"><span style="color: gold">&#9733; </span>${product.PropReview}</h5>
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
                fetch('/Data/listinglist.json')
                    .then(response => response.json())
                    .then(data => {
                        products = data;
                        addDataToHTML();

                    })
            }
            initApp();
        })

        function showListing(button) {
            document.getElementById('<%=hfListing.ClientID%>').value = button.id;
            __doPostBack();
        }
    </script>
</asp:Content>
