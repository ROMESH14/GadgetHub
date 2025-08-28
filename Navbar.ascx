<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navbar.ascx.cs" Inherits="GadgetHub.WebClient.Navbar" %>

<style>
    .navbar {
        background-color: #343a40;
        padding: 14px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }

    .navbar .brand {
        color: white;
        font-weight: bold;
        font-size: 22px;
        text-decoration: none;
    }

    .navbar a {
        color: #f8f9fa;
        text-decoration: none;
        margin-left: 25px;
        font-size: 16px;
        transition: color 0.3s ease;
    }

    .navbar a:hover {
        color: #17a2b8;
    }

    .nav-links {
        display: flex;
        align-items: center;
    }

    .navbar a i {
        margin-right: 6px;
    }
</style>

<nav class="navbar">
    <a class="brand" href="Default.aspx"> GadgetHub</a>
    <div class="nav-links">
        <a href="Default.aspx">🏠 Home</a>
        <a href="Order.aspx">🛍️ Products</a>
        <a href="Cart.aspx">🛒 Cart</a>
        <a href="Checkout.aspx">✅ Checkout</a>
        <a href="ViewOrders.aspx">📦 Order History</a>
    </div>
</nav>
