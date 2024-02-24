<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="MOCKAirBNB.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="CSS/home-design.css" />
    <title></title>
</head>
<body>
    <nav>
    <div class="nav-bar-container">
        <div>Home logo Image</div>
        <div>
            <a href="#">Home</a>
            <a href="#">Discover</a>
            <a href="#">About</a>
            <a href="#">Contact</a>
        </div>
        <div>
            <button class="register">Register</button>
            <button class="signin">Sign In</button>
        </div>
    </div>
</nav>

<header>
    <form id="form1" runat="server">
        <div class="img-container">

            <img src="Images/background-img.jpg" />
            <div class="img-text-container">
                <h1>Enjoy Your Dream Vacation</h1>
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
    </form>
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
</body>
</html>
