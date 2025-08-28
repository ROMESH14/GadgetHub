<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewOrders.aspx.cs" Inherits="GadgetHub.WebClient.ViewOrders" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order History - GadgetHub</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: linear-gradient(135deg, #f3e5f5, #ede7f6);
            margin: 0;
            padding: 0;
        }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 60px auto;
            padding: 30px 40px;
            background-color: #fff;
            border-radius: 14px;
            box-shadow: 0 10px 25px rgba(123, 31, 162, 0.15);
        }

        h2 {
            text-align: center;
            color: #6a1b9a;
            margin-bottom: 30px;
            font-size: 30px;
            font-weight: bold;
        }

        h3 {
            color: #512da8;
            font-size: 20px;
            margin-bottom: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        .table th,
        .table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        .table th {
            background-color: #7e57c2;
            color: white;
            font-weight: 600;
        }

        .table tr:nth-child(even) {
            background-color: #f9f1fc;
        }

        .table tr:hover {
            background-color: #f3e5f5;
        }

        .highlight-row {
            background-color: #d4edda;
            font-weight: bold;
        }

        .section {
            background-color: #ffffff;
            padding: 25px 30px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(103, 58, 183, 0.1);
        }

        .grand-total {
            font-weight: 600;
            font-size: 18px;
            color: #6a1b9a;
            text-align: right;
            display: block;
            margin-top: 20px;
        }

        .error-message {
            color: #c62828;
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <uc:Navbar runat="server" ID="Navbar" />

        <div class="container">
            <h2>📦 Order History</h2>

            <div class="section">
                <h3>🧾 Orders Placed by You</h3>

                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False"
                              CssClass="table" OnRowDataBound="gvOrders_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
                        <asp:BoundField DataField="ProductId" HeaderText="Product ID" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price (LKR)" DataFormatString="LKR {0:N2}" />
                        <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
                        <asp:BoundField DataField="TotalPrice" HeaderText="Total Price (LKR)" DataFormatString="LKR {0:N2}" />
                        <asp:BoundField DataField="EstimatedDeliveryDays" HeaderText="Delivery (Days)" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    </Columns>
                </asp:GridView>

                <asp:Label ID="lblOrdersTotal" runat="server" CssClass="grand-total" />
                <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>
