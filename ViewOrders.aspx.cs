using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.WebClient
{
    public partial class ViewOrders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
                gvOrders.RowDataBound += gvOrders_RowDataBound;
            }
        }

        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (decimal.TryParse(DataBinder.Eval(e.Row.DataItem, "TotalPrice")?.ToString(), out decimal price))
                {
                    if (price > 200000)
                    {
                        e.Row.CssClass = "highlight-row"; // apply CSS
                    }
                }
            }
        }

        private void LoadOrders()
        {
            string connStr = ConfigurationManager.ConnectionStrings["HubDB"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = @"
                        SELECT 
                            OrderId, 
                            ProductId, 
                            Quantity, 
                            UnitPrice, 
                            (Quantity * UnitPrice) AS TotalPrice,
                            DistributorName, 
                            EstimatedDeliveryDays, 
                            OrderDate 
                        FROM CartOrders 
                        ORDER BY OrderDate DESC";

                    using (SqlDataAdapter adapter = new SqlDataAdapter(sql, conn))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            if (string.IsNullOrWhiteSpace(row["DistributorName"]?.ToString()))
                                row["DistributorName"] = "❌ Not Provided";

                            if (int.TryParse(row["EstimatedDeliveryDays"]?.ToString(), out int days) && days <= 0)
                                row["EstimatedDeliveryDays"] = DBNull.Value;
                        }

                        if (dt.Rows.Count > 0)
                        {
                            decimal minPrice = dt.AsEnumerable()
                                .Min(row => row.Field<decimal>("UnitPrice"));

                            gvOrders.DataSource = dt;
                            gvOrders.DataBind();

                            foreach (GridViewRow row in gvOrders.Rows)
                            {
                                if (decimal.TryParse(row.Cells[3].Text.Replace("LKR", "").Trim(), out decimal rowPrice))
                                {
                                    if (rowPrice == minPrice)
                                    {
                                        row.BackColor = System.Drawing.Color.LightGreen;
                                        row.Font.Bold = true;
                                    }
                                }
                            }

                            // Calculate grand total
                            decimal grandTotal = dt.AsEnumerable()
                                .Sum(row => row.Field<decimal>("UnitPrice") * row.Field<int>("Quantity"));

                            lblOrdersTotal.Text = $"🧾 Grand Total of Orders: <b>LKR {grandTotal:N2}</b>";
                            lblOrdersTotal.ForeColor = System.Drawing.Color.DarkBlue;
                        }
                        else
                        {
                            gvOrders.DataSource = null;
                            gvOrders.DataBind();
                            lblOrdersTotal.Text = "❌ No orders found.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblOrdersTotal.Text = "❌ Error loading orders: " + ex.Message;
                lblOrdersTotal.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
