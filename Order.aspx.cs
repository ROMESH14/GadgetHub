using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using GadgetHub.Models;
using GadgetHub.WebClient.Models;
using Newtonsoft.Json;

namespace GadgetHub.WebClient
{
    public partial class Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnViewCart.Visible = false; 
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            lblResult.Text = "";
            phDistributorTable.Controls.Clear();
            btnViewCart.Visible = false;

            if (string.IsNullOrEmpty(ddlProduct.SelectedValue) || string.IsNullOrWhiteSpace(txtQuantity.Text))
            {
                lblResult.ForeColor = System.Drawing.Color.Red;
                lblResult.Text = "⚠️ Please select a product and enter quantity.";
                return;
            }

            try
            {
                int productId = int.Parse(ddlProduct.SelectedValue);
                int quantity = int.Parse(txtQuantity.Text);

                var requestList = new List<QuotationRequest>
                {
                    new QuotationRequest { ProductId = productId, Quantity = quantity }
                };

                var quotations = new List<QuotationResponse>();
                string[] distributorApis =
                {
                    "https://localhost:44364/api/quotation/get",  // TechWorld
                    "https://localhost:44391/api/quotation/get",  // ElectroCom
                    "https://localhost:44307/api/quotation/get"   // Gadget Central
                };

                System.Net.ServicePointManager.ServerCertificateValidationCallback +=
                    (sender2, cert, chain, errors) => true;

                foreach (string api in distributorApis)
                {
                    using (HttpClient client = new HttpClient())
                    {
                        var json = JsonConvert.SerializeObject(requestList);
                        var content = new StringContent(json, Encoding.UTF8, "application/json");

                        var response = client.PostAsync(api, content).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            var resultJson = response.Content.ReadAsStringAsync().Result;
                            var quoteList = JsonConvert.DeserializeObject<List<QuotationResponse>>(resultJson);
                            if (quoteList != null)
                                quotations.AddRange(quoteList);
                        }
                    }
                }

                if (!quotations.Any())
                {
                    lblResult.ForeColor = System.Drawing.Color.Red;
                    lblResult.Text = "❌ No quotations received from distributors.";
                    return;
                }

                var bestQuote = quotations
                    .Where(q => q.ProductId == productId &&
                                !string.IsNullOrWhiteSpace(q.DistributorName) &&
                                q.EstimatedDeliveryDays > 0)
                    .OrderBy(q => q.UnitPrice)
                    .FirstOrDefault();

                if (bestQuote == null)
                {
                    lblResult.ForeColor = System.Drawing.Color.Red;
                    lblResult.Text = "❌ No valid quotation with distributor info found.";
                    return;
                }

                
                string gadgetHubApi = "https://localhost:44354/api/order/placeorder";
                var bestQuoteRequest = new List<QuotationRequest>
                {
                    new QuotationRequest { ProductId = productId, Quantity = quantity }
                };

                using (HttpClient client = new HttpClient())
                {
                    var json = JsonConvert.SerializeObject(bestQuoteRequest);
                    var content = new StringContent(json, Encoding.UTF8, "application/json");

                    var response = client.PostAsync(gadgetHubApi, content).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        DisplayBestQuotation(bestQuote, productId, quantity);
                        lblResult.ForeColor = System.Drawing.Color.Green;
                        lblResult.Text += "<br/><b>✅ Order saved via GadgetHub.API!</b>";

                        
                        var cartItem = new CartItem
                        {
                            ProductId = bestQuote.ProductId,
                            ProductName = ddlProduct.SelectedItem.Text,
                            UnitPrice = bestQuote.UnitPrice,
                            Quantity = quantity,
                            DistributorName = bestQuote.DistributorName,
                            EstimatedDeliveryDays = bestQuote.EstimatedDeliveryDays,
                            ImageUrl = GetImageUrlByProductId(bestQuote.ProductId)
                        };

                        List<CartItem> cart = new List<CartItem> { cartItem };
                        Session["Cart"] = cart;

                        btnViewCart.Visible = true;
                    }
                    else
                    {
                        lblResult.ForeColor = System.Drawing.Color.Red;
                        lblResult.Text = "❌ Failed to save order via GadgetHub.API.";
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.ForeColor = System.Drawing.Color.Red;
                lblResult.Text = "❌ An error occurred: " + ex.Message;

                if (ex.InnerException != null)
                    lblResult.Text += "<br/><small>" + ex.InnerException.Message + "</small>";
            }
        }

        private void DisplayBestQuotation(QuotationResponse quote, int productId, int quantity)
        {
            lblResult.ForeColor = System.Drawing.Color.Green;
            lblResult.Text = "✅ Best quotation selected!<br/><b>Distributor Info:</b><br/>";

            Table table = new Table { BorderWidth = 1, GridLines = GridLines.Both };

            TableHeaderRow header = new TableHeaderRow();
            header.Cells.Add(CreateCell("Product ID", true));
            header.Cells.Add(CreateCell("Unit Price (LKR)", true));
            header.Cells.Add(CreateCell("Quantity", true));
            header.Cells.Add(CreateCell("Total (LKR)", true));
            header.Cells.Add(CreateCell("Distributor", true));
            table.Rows.Add(header);

            decimal total = quote.UnitPrice * quantity;

            TableRow row = new TableRow();
            row.Cells.Add(CreateCell(productId.ToString()));
            row.Cells.Add(CreateCell("LKR " + quote.UnitPrice.ToString("N2")));
            row.Cells.Add(CreateCell(quantity.ToString()));
            row.Cells.Add(CreateCell("LKR " + total.ToString("N2")));
            row.Cells.Add(CreateCell(quote.DistributorName));
            table.Rows.Add(row);

            TableRow totalRow = new TableRow();
            totalRow.Cells.Add(new TableCell
            {
                ColumnSpan = 3,
                Text = "<b>Grand Total:</b>",
                HorizontalAlign = HorizontalAlign.Right
            });
            totalRow.Cells.Add(new TableCell
            {
                ColumnSpan = 2,
                Text = "<b>LKR " + total.ToString("N2") + "</b>",
                HorizontalAlign = HorizontalAlign.Left
            });
            table.Rows.Add(totalRow);

            phDistributorTable.Controls.Add(table);
        }

        private TableCell CreateCell(string text, bool isHeader = false)
        {
            TableCell cell = isHeader ? new TableHeaderCell() : new TableCell();
            cell.Text = text;
            cell.HorizontalAlign = HorizontalAlign.Center;
            if (isHeader) cell.Font.Bold = true;
            return cell;
        }

        private string GetImageUrlByProductId(int productId)
        {
            switch (productId)
            {
                case 1: return "~/Images/smartphone.jpeg";
                case 2: return "~/Images/laptop.jpeg";
                case 3: return "~/Images/tablet.jpeg";
                case 4: return "~/Images/earbuds.jpeg";
                default: return "~/Images/default.png";
            }
        }
    }
}
