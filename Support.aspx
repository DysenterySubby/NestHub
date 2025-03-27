<%@ Page Title="" Language="C#" MasterPageFile="~/NestHub.Master" AutoEventWireup="true" CodeBehind="Support.aspx.cs" Inherits="MOCKAirBNB.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="m-3">
        <div class="container mt-5 pt-5 px-5">
            <h2 class="fw-bold mb-3">WELCOME TO THE HELP CENTER</h2>
            <div
                class="container border border-3 rounded d-flex justify-content-evenly align-items-center px-5 py-4">
                <div>
                    <div class="d-flex align-items-center">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="30"
                            height="30"
                            fill="currentColor"
                            class="bi bi-ticket mb-4 me-2 text-warning"
                            viewBox="0 0 16 16">
                            <path
                                d="M0 4.5A1.5 1.5 0 0 1 1.5 3h13A1.5 1.5 0 0 1 16 4.5V6a.5.5 0 0 1-.5.5 1.5 1.5 0 0 0 0 3 .5.5 0 0 1 .5.5v1.5a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 11.5V10a.5.5 0 0 1 .5-.5 1.5 1.5 0 1 0 0-3A.5.5 0 0 1 0 6zM1.5 4a.5.5 0 0 0-.5.5v1.05a2.5 2.5 0 0 1 0 4.9v1.05a.5.5 0 0 0 .5.5h13a.5.5 0 0 0 .5-.5v-1.05a2.5 2.5 0 0 1 0-4.9V4.5a.5.5 0 0 0-.5-.5z" />
                        </svg>
                        <div class="mb-4">
                            <h3 class="m-0 pt-3">Submit a ticket</h3>
                            <p class="m-0">(Scroll down to submit)</p>
                        </div>
                    </div>
                    <div class="ms-4 ps-3">
                        <p class="m-0 pb-4">
                            Provide your inquiries through our website, and we'll reply to
            you via your provided email.
                        </p>
                    </div>
                </div>
                <div>
                    <div class="d-flex align-items-center">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="30"
                            height="30"
                            fill="currentColor"
                            class="bi bi-envelope mb-4 me-2 text-warning"
                            viewBox="0 0 16 16">
                            <path
                                d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                        </svg>
                        <div class="mb-4">
                            <h3 class="m-0 pt-3">Send us an Email</h3>
                            <p class="m-0">user@nesthub.com</p>
                        </div>
                    </div>
                    <div class="ms-4 ps-3">
                        <p class="m-0 pb-4">
                            Contact our team about your booking, we'll reply as soon as
            possible.
                        </p>
                    </div>
                </div>
                <div>
                    <div class="d-flex align-items-center">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="30"
                            height="30"
                            fill="currentColor"
                            class="bi bi-phone mb-4 me-2 text-warning"
                            viewBox="0 0 16 16">
                            <path
                                d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" />
                            <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
                        </svg>
                        <div class="mb-4">
                            <h3 class="m-0 pt-3">Call us</h3>
                            <p class="m-0">+63 987 654 3210</p>
                        </div>
                    </div>
                    <div class="ms-4 ps-3">
                        <p class="m-0 pb-4">
                            For anything urgent, you can call us with the provided phone
            number.
                        </p>
                    </div>
                </div>
            </div>
            <h2 class="pt-5 fw-bold mb-3">SUBMIT A TICKET</h2>
            <div class="container border border-3 rounded px-5 py-4 mb-5">
                <div class="form-floating mb-3 w-50">
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Enter your name." ControlToValidate="tbName" ValidationGroup="Ticket" ForeColor="red"></asp:RequiredFieldValidator>
                    <input
                        id="tbName"
                        runat="server"
                        type="text"
                        class="form-control"
                        placeholder="Name" />
                    <label for="tbName">Name</label>
                </div>
                <div class="form-floating mb-3 w-50">
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Enter your email." ControlToValidate="tbEmail" ValidationGroup="Ticket" ForeColor="red"></asp:RequiredFieldValidator>
                    <input
                        id="tbEmail"
                        runat="server"
                        type="email"
                        class="form-control"
                        placeholder="Email" />
                    <label for="tbEmail">Email</label>
                </div>
                <div class="form-floating mb-3 w-50">
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ErrorMessage="Enter your phone no." ControlToValidate="tbPhone" ValidationGroup="Ticket" ForeColor="red"></asp:RequiredFieldValidator>
                    <input
                        id="tbPhone"
                        runat="server"
                        type="tel"
                        class="form-control"
                        placeholder="Phone Number" />
                    <label for="tbPhone">Phone Number</label>
                </div>
                <div class="form-floating">
                    <asp:RequiredFieldValidator ID="rfvInquiry" runat="server" ErrorMessage="Please add an inquiry" ControlToValidate="tbInquiry" ValidationGroup="Ticket" ForeColor="red"></asp:RequiredFieldValidator>
                    <textarea
                        id="tbInquiry"
                        runat="server"
                        class="form-control"
                        placeholder="Inquiry"
                        style="height: 150px"></textarea>
                    <label for="tbInquiry">Inquiry</label>
                </div>
                <div class="container mt-4 mb-4 text-center">
                    <asp:Button ID="btnTicket" runat="server" Text="Submit Ticket" class="btn btn-warning btn-lg pe-5 ps-5 pt-2 pb-2 fw-bold rounded-5 w" OnClick="TicketSubmit" ValidationGroup="Ticket"/>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
