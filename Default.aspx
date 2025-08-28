<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GadgetHub.WebClient._Default" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <uc:Navbar runat="server" ID="Navbar" />

    <style>
        body {
            background: linear-gradient(135deg, #ede7f6, #f3e5f5);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .hero-section {
            background: linear-gradient(to right, #7b1fa2, #512da8);
            color: white;
            text-align: center;
            padding: 80px 30px;
            border-radius: 16px;
            margin-top: 30px;
            box-shadow: 0 6px 24px rgba(0, 0, 0, 0.2);
        }

        .hero-title {
            font-size: 50px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .hero-subtitle {
            font-size: 20px;
            font-weight: 300;
            margin-bottom: 30px;
        }

        .hero-button {
            background: linear-gradient(to right, #ab47bc, #7e57c2);
            color: white;
            padding: 14px 32px;
            font-size: 18px;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(171, 71, 188, 0.4);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .hero-button:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(126, 87, 194, 0.6);
            background: linear-gradient(to right, #8e24aa, #5e35b1);
        }

        .section-title {
            font-size: 36px;
            text-align: center;
            margin: 60px 0 30px;
            color: #4a148c;
        }

        .product-card {
            border: none;
            border-radius: 16px;
            padding: 20px;
            margin: 15px;
            text-align: center;
            background: white;
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .product-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            margin-bottom: 15px;
            border-radius: 10px;
        }

        .product-name {
            font-weight: bold;
            font-size: 20px;
            color: #6a1b9a;
            margin-bottom: 10px;
        }

        .add-button {
            background: linear-gradient(to right, #8e24aa, #7e57c2);
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(142, 36, 170, 0.3);
            text-decoration: none;
        }

        .add-button:hover {
            background: linear-gradient(to right, #6a1b9a, #5e35b1);
            box-shadow: 0 6px 15px rgba(106, 27, 154, 0.5);
        }
    </style>

    <div class="hero-section">
        <div class="hero-title">Welcome to The Gadget Hub</div>
        <div class="hero-subtitle">Shop the latest gadgets from top distributors</div>
        <a href="Order.aspx" class="hero-button">🚀 Place Your Gadget Order</a>
    </div>

    <h2 class="section-title">✨ Featured Gadgets</h2>

    <div class="row justify-content-center">

        <div class="col-md-3 col-sm-6">
            <div class="product-card">
                <img src="Images/smartphone.jpeg" alt="Smartphone" class="product-image" />
                <div class="product-name">Smartphone</div>
                <asp:LinkButton runat="server" CssClass="add-button" CommandName="AddToCart" CommandArgument="1" OnCommand="Product_Command">Add to Cart</asp:LinkButton>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="product-card">
                <img src="Images/laptop.jpeg" alt="Laptop" class="product-image" />
                <div class="product-name">Laptop</div>
                <asp:LinkButton runat="server" CssClass="add-button" CommandName="AddToCart" CommandArgument="2" OnCommand="Product_Command">Add to Cart</asp:LinkButton>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="product-card">
                <img src="Images/smartwatch.jpeg" alt="Smartwatch" class="product-image" />
                <div class="product-name">Smartwatch</div>
                <asp:LinkButton runat="server" CssClass="add-button" CommandName="AddToCart" CommandArgument="3" OnCommand="Product_Command">Add to Cart</asp:LinkButton>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="product-card">
                <img src="Images/earbuds.jpeg" alt="Wireless Earbuds" class="product-image" />
                <div class="product-name">Wireless Earbuds</div>
                <asp:LinkButton runat="server" CssClass="add-button" CommandName="AddToCart" CommandArgument="4" OnCommand="Product_Command">Add to Cart</asp:LinkButton>
            </div>
        </div>

    </div>

</asp:Content>
