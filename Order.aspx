<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="GadgetHub.WebClient.Order" %>
<%@ Register Src="~/Navbar.ascx" TagName="Navbar" TagPrefix="uc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Place Your Order - GadgetHub</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f3e5f5, #ede7f6);
            margin: 0;
            padding: 0;
        }

        .order-container {
            max-width: 650px;
            margin: 70px auto;
            background-color: #fff;
            padding: 40px 35px;
            border-radius: 16px;
            box-shadow: 0px 8px 24px rgba(123, 31, 162, 0.2);
        }

        h2 {
            text-align: center;
            color: #6a1b9a;
            font-size: 28px;
            margin-bottom: 30px;
            font-weight: 700;
        }

        label {
            color: #4a148c;
            font-weight: 600;
        }

        .form-control {
            border-radius: 8px;
            height: 44px;
            font-size: 16px;
        }

        .btn-order {
            background: linear-gradient(to right, #8e24aa, #7e57c2);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            padding: 12px 0;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(142, 36, 170, 0.3);
        }

        .btn-order:hover {
            background: linear-gradient(to right, #6a1b9a, #5e35b1);
            box-shadow: 0 6px 18px rgba(106, 27, 154, 0.4);
        }

        .alert {
            margin-top: 20px;
            font-size: 16px;
            font-weight: bold;
            color: #2e7d32;
        }

        .results-area table {
            margin-top: 25px;
            border-collapse: collapse;
            width: 100%;
            border-radius: 10px;
            overflow: hidden;
        }

        .results-area th, .results-area td {
            padding: 12px;
            text-align: center;
            border: 1px solid #d1c4e9;
        }

        .results-area th {
            background-color: #7e57c2;
            color: white;
        }

        .results-area tr:nth-child(even) {
            background-color: #f3e5f5;
        }

        .view-cart-btn {
            font-weight: 600;
            padding: 10px 28px;
            margin-top: 20px;
            border-radius: 8px;
            background-color: transparent;
            border: 2px solid #7e57c2;
            color: #7e57c2;
            transition: all 0.3s ease;
        }

        .view-cart-btn:hover {
            background-color: #7e57c2;
            color: white;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <uc:Navbar runat="server" ID="Navbar" />

        <div class="order-container">
            <h2>📦 Place Your Gadget Order</h2>

            <!-- Product Selection -->
            <div class="mb-3">
                <label for="ddlProduct">Select Product:</label>
                <asp:DropDownList ID="ddlProduct" runat="server" CssClass="form-control">
                    <asp:ListItem Text="-- Choose a Product --" Value="" />
                    <asp:ListItem Text="Smartphone" Value="1" />
                    <asp:ListItem Text="Laptop" Value="2" />
                    <asp:ListItem Text="Smart-Watch" Value="3" />
                    <asp:ListItem Text="Wireless-Earbuds" Value="4" />
                </asp:DropDownList>
            </div>

            <!-- Quantity -->
            <div class="mb-3">
                <label for="txtQuantity">Quantity:</label>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" Min="1" />
            </div>

            <!-- Place Order Button -->
            <asp:Button ID="btnPlaceOrder" runat="server" Text="📥 Place Order" CssClass="btn btn-order w-100" OnClick="btnPlaceOrder_Click" />

            <!-- Result Message & Distributor Table -->
            <div class="results-area text-center">
                <asp:Label ID="lblResult" runat="server" CssClass="alert" EnableViewState="false" />
                <asp:PlaceHolder ID="phDistributorTable" runat="server" />
            </div>

            <!-- View Cart Button -->
            <div class="text-center">
                <asp:Button ID="btnViewCart" runat="server" Text="🛒 View Cart"
                    CssClass="btn view-cart-btn"
                    PostBackUrl="~/Cart.aspx"
                    Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>
