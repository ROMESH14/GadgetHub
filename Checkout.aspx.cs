using System;
using System.Collections.Generic;
using System.Linq;
using GadgetHub.Models;
using GadgetHub.WebClient.Models;

namespace GadgetHub.WebClient
{
    public partial class Checkout : System.Web.UI.Page
    {
        private readonly Random rnd = new Random();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SelectedProduct"] != null)
                {
                    var product = (CartItem)Session["SelectedProduct"];
                    DisplayQuotations(product.ProductId, product.Quantity);
                    gvQuotations.RowDataBound += gvQuotations_RowDataBound;
                }
                else
                {
                    lblMessage.Text = "❌ No product selected for checkout.";
                    btnCheckout.Visible = false;
                }
            }
        }

        private void DisplayQuotations(int productId, int quantity)
        {
            var quotes = new List<Quote>
            {
                GetQuoteFromTechWorld(productId),
                GetQuoteFromElectroCom(productId),
                GetQuoteFromGadgetCentral(productId)
            };

            // Calculate total price
            foreach (var q in quotes)
            {
                q.TotalPrice = q.Price * quantity;
            }

            gvQuotations.DataSource = quotes;
            gvQuotations.DataBind();

            var bestQuote = quotes
                .Where(q => q.InStock)
                .OrderBy(q => q.TotalPrice)
                .ThenBy(q => q.EstimatedDeliveryDays)
                .FirstOrDefault();

            if (bestQuote != null)
            {
                Session["BestQuote"] = bestQuote;
                lblMessage.Text = $"✅ Best Option: <b>{bestQuote.DistributorName}</b> - LKR {bestQuote.Price:N2} per unit";
            }
            else
            {
                lblMessage.Text = "❌ No available stock from any distributor.";
                btnCheckout.Visible = false;
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["SelectedProduct"] != null && Session["BestQuote"] != null)
            {
                var product = (CartItem)Session["SelectedProduct"];
                var quote = (Quote)Session["BestQuote"];

                // Redirect to order summary or save
                Response.Redirect("ViewOrders.aspx");
            }
        }

        private Quote GetQuoteFromTechWorld(int productId)
        {
            int price;
            switch (productId)
            {
                case 1: price = rnd.Next(80900, 81000); break; // Smartphone
                case 2: price = rnd.Next(141000, 141500); break; // Laptop
                case 3: price = rnd.Next(63500, 63800); break;   // Earbuds
                case 4: price = rnd.Next(18500, 18700); break;   // Smart Watch
                default: price = 99999; break;
            }

            return new Quote
            {
                DistributorName = "TechWorld",
                Price = price,
                InStock = rnd.Next(0, 2) == 1,
                EstimatedDeliveryDays = rnd.Next(3, 7)
            };
        }

        private Quote GetQuoteFromElectroCom(int productId)
        {
            int price;
            switch (productId)
            {
                case 1: price = rnd.Next(82500, 82700); break;
                case 2: price = rnd.Next(140000, 141000); break;
                case 3: price = rnd.Next(62500, 62700); break;
                case 4: price = rnd.Next(18700, 18900); break;
                default: price = 99999; break;
            }

            return new Quote
            {
                DistributorName = "ElectroCom",
                Price = price,
                InStock = rnd.Next(0, 2) == 1,
                EstimatedDeliveryDays = rnd.Next(2, 6)
            };
        }

        private Quote GetQuoteFromGadgetCentral(int productId)
        {
            int price;
            switch (productId)
            {
                case 1: price = rnd.Next(85000, 85500); break;
                case 2: price = rnd.Next(139500, 140000); break;
                case 3: price = rnd.Next(63700, 64000); break;
                case 4: price = rnd.Next(18800, 19000); break;
                default: price = 99999; break;
            }

            return new Quote
            {
                DistributorName = "Gadget Central",
                Price = price,
                InStock = rnd.Next(0, 2) == 1,
                EstimatedDeliveryDays = rnd.Next(4, 8)
            };
        }

        protected void gvQuotations_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
            {
                var quote = (Quote)e.Row.DataItem;
                var bestQuote = Session["BestQuote"] as Quote;

                if (bestQuote != null && quote.DistributorName == bestQuote.DistributorName)
                {
                    e.Row.CssClass = "highlight";
                }
            }
        }
    }
}
