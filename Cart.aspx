<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="GadgetHub.WebClient.Cart" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your Shopping Cart - GadgetHub</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f3e5f5, #ede7f6);
            margin: 0;
            padding: 0;
        }

        .container-box {
            max-width: 1100px;
            margin: 60px auto;
            background: #fff;
            padding: 40px 35px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(123, 31, 162, 0.15);
        }

        h2 {
            text-align: center;
            color: #6a1b9a;
            font-weight: 700;
            margin-bottom: 30px;
        }

        .cart-table th, .cart-table td {
            padding: 14px;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #ddd;
        }

        .cart-table th {
            background-color: #7e57c2;
            color: white;
            font-weight: 600;
        }

        .cart-table tr:nth-child(even) {
            background-color: #f9f1fc;
        }

        .cart-table img {
            width: 90px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
        }

        .quantity-controls {
            display: flex;
            justify-content: center;
            gap: 6px;
            align-items: center;
        }

        .quantity-controls a {
            text-decoration: none;
            font-size: 18px;
            padding: 4px 10px;
            background-color: #e1bee7;
            border-radius: 6px;
            color: #6a1b9a;
            font-weight: bold;
        }

        .remove-button {
            background-color: #d32f2f;
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 14px;
        }

        .remove-button:hover {
            background-color: #b71c1c;
        }

        .total-row {
            font-size: 20px;
            font-weight: bold;
            color: #4a148c;
            margin: 20px 0;
            text-align: right;
            display: block;
        }

        .btn-checkout, .btn-view {
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 8px;
            margin-left: 10px;
        }

        .btn-checkout {
            background: linear-gradient(to right, #8e24aa, #7e57c2);
            border: none;
            color: white;
        }

        .btn-checkout:hover {
            background: linear-gradient(to right, #6a1b9a, #5e35b1);
        }

        .btn-view {
            background-color: #7e57c2;
            border: none;
            color: white;
        }

        .btn-view:hover {
            background-color: #5e35b1;
        }

        .button-section {
            text-align: right;
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <uc:Navbar runat="server" ID="Navbar" />

        <div class="container-box">
            <h2>🛒 Your Shopping Cart</h2>

            <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="cart-table table"
                OnRowCommand="gvCart_RowCommand" DataKeyNames="ProductId">
                <Columns>
                    <asp:ImageField DataImageUrlField="ImageUrl" HeaderText="Image" ControlStyle-Width="100px" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product" />
                    <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price (LKR)" DataFormatString="LKR {0:N2}" HtmlEncode="false" />
                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <div class="quantity-controls">
                                <asp:LinkButton ID="btnDecrease" runat="server" Text="➖" CommandName="Decrease" CommandArgument='<%# Container.DataItemIndex %>' />
                                <%# Eval("Quantity") %>
                                <asp:LinkButton ID="btnIncrease" runat="server" Text="➕" CommandName="Increase" CommandArgument='<%# Container.DataItemIndex %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total (LKR)">
                        <ItemTemplate>
                            LKR <%# (Convert.ToDecimal(Eval("UnitPrice")) * Convert.ToInt32(Eval("Quantity"))).ToString("N2") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Remove" CommandName="Remove"
                                CommandArgument='<%# Container.DataItemIndex %>' CssClass="remove-button" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblTotal" runat="server" CssClass="total-row" />

            <div class="button-section">
                <asp:Button ID="btnPlaceOrder" runat="server" Text="📦 Place Order" OnClick="btnPlaceOrder_Click" CssClass="btn btn-checkout" />
                <asp:Button ID="btnCheckout" runat="server" Text="🧾 Compare Quotations" OnClick="btnCheckout_Click" CssClass="btn btn-checkout" />
                <asp:Button ID="btnViewOrders" runat="server" Text="📜 View Orders" CssClass="btn btn-view" OnClick="btnViewOrders_Click" Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>
