<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="GadgetHub.WebClient.Checkout" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout - GadgetHub</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f0f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #6a1b9a;
            margin-bottom: 30px;
        }

        .quote-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .quote-table th,
        .quote-table td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
            font-size: 15px;
        }

        .quote-table th {
            background-color: #7e57c2;
            color: white;
        }

        .quote-table tr.highlight {
            background-color: #e1bee7;
        }

        .message-label {
            display: block;
            font-size: 18px;
            margin-top: 20px;
            color: #6a1b9a;
            text-align: center;
        }

        .checkout-button {
            display: block;
            width: 200px;
            margin: 0 auto;
            margin-top: 20px;
            padding: 12px;
            background: linear-gradient(to right, #8e24aa, #7e57c2);
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .checkout-button:hover {
            background: linear-gradient(to right, #6a1b9a, #5e35b1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:Navbar runat="server" ID="Navbar" />

        <div class="container">
            <h2>Compare Quotations & Place Order</h2>

            <asp:GridView ID="gvQuotations" runat="server" AutoGenerateColumns="False" CssClass="quote-table">
                <Columns>
                    <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
                    <asp:BoundField DataField="Price" HeaderText="Unit Price (LKR)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="TotalPrice" HeaderText="Total (LKR)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="InStockText" HeaderText="Availability" />
                    <asp:BoundField DataField="EstimatedDeliveryDays" HeaderText="Delivery Days" />
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblMessage" runat="server" CssClass="message-label" />

            <asp:Button ID="btnCheckout" runat="server" Text="✅ Place Order" CssClass="checkout-button" OnClick="btnCheckout_Click" />
        </div>
    </form>
</body>
</html>
