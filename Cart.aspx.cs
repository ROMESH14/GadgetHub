using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using GadgetHub.WebClient.Models;
using System.Data.SqlClient;
using System.Configuration;

namespace GadgetHub.WebClient
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnViewOrders.Visible = false;
                btnCheckout.Visible = true;

                // Bind cart items
                var cart = Session["Cart"] as List<CartItem>;
                if (cart != null && cart.Any())
                {
                    gvCart.DataSource = cart;
                    gvCart.DataBind();

                    decimal total = cart.Sum(item => item.UnitPrice * item.Quantity);
                    lblTotal.Text = $"Grand Total: LKR {total:N2}";
                    lblTotal.ForeColor = System.Drawing.Color.DarkViolet;
                }
                else
                {
                    lblTotal.Text = "🛒 Your shopping cart is empty.";
                    lblTotal.ForeColor = System.Drawing.Color.OrangeRed;
                }
            }
        }


        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;

            if (cart == null || !cart.Any())
            {
                lblTotal.Text = "⚠️ Your cart is empty.";
                lblTotal.ForeColor = System.Drawing.Color.Red;
                return;
            }

            foreach (var item in cart)
            {
                SaveCartItemToDatabase(item);
            }

            Session["Cart"] = null;
            gvCart.DataSource = null;
            gvCart.DataBind();

            lblTotal.Text = "✅ Thank you! Your order has been placed successfully.";
            lblTotal.ForeColor = System.Drawing.Color.Green;

            btnPlaceOrder.Visible = false;
            btnCheckout.Visible = false;
            btnViewOrders.Visible = true;
        }

        protected void btnViewOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ViewOrders.aspx");
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Increase" || e.CommandName == "Decrease")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var cart = Session["Cart"] as List<CartItem>;

                if (cart != null && index >= 0 && index < cart.Count)
                {
                    if (e.CommandName == "Increase")
                        cart[index].Quantity++;
                    else if (e.CommandName == "Decrease" && cart[index].Quantity > 1)
                        cart[index].Quantity--;

                    gvCart.DataSource = cart;
                    gvCart.DataBind();
                    Session["Cart"] = cart;
                }
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;

            if (cart != null && cart.Any())
            {
                // Assume single-product comparison for simplicity
                var selected = cart.First();
                Session["SelectedProduct"] = selected;

                Response.Redirect("~/Checkout.aspx");
            }
            else
            {
                lblTotal.Text = "⚠️ Your cart is empty.";
                lblTotal.ForeColor = System.Drawing.Color.Red;
            }
        }


        private void SaveCartItemToDatabase(CartItem item)
        {
            string connStr = ConfigurationManager.ConnectionStrings["HubDB"].ConnectionString;

            decimal unitPrice = item.UnitPrice;
            string distributor = string.IsNullOrWhiteSpace(item.DistributorName) ? "Unknown" : item.DistributorName;
            int deliveryDays = item.EstimatedDeliveryDays > 0 ? item.EstimatedDeliveryDays : 3;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string insertQuery = @"
                    INSERT INTO CartOrders 
                    (ProductId, ProductName, Quantity, UnitPrice, DistributorName, EstimatedDeliveryDays, OrderDate) 
                    VALUES 
                    (@ProductId, @ProductName, @Quantity, @UnitPrice, @DistributorName, @EstimatedDeliveryDays, @OrderDate)";

                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@ProductId", item.ProductId);
                    insertCmd.Parameters.AddWithValue("@ProductName", item.ProductName);
                    insertCmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                    insertCmd.Parameters.AddWithValue("@UnitPrice", unitPrice);
                    insertCmd.Parameters.AddWithValue("@DistributorName", distributor);
                    insertCmd.Parameters.AddWithValue("@EstimatedDeliveryDays", deliveryDays);
                    insertCmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);

                    conn.Open();
                    insertCmd.ExecuteNonQuery();
                }
            }
        }
    }
}
