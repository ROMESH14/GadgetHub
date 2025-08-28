using GadgetHub.WebClient.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.WebClient
{
    public partial class _Default : Page
    {
        protected void Product_Command(object sender, CommandEventArgs e)
        {
            int productId = int.Parse(e.CommandArgument.ToString());

          
            string name = "";
            decimal price = 0;
            string imageUrl = "";

            switch (productId)
            {
                case 1:
                    name = "Smartphone";
                    price = 149999;
                    imageUrl = "Images/smartphone.jpeg";
                    break;
                case 2:
                    name = "Laptop";
                    price = 299999;
                    imageUrl = "Images/laptop.jpeg";
                    break;
                case 3:
                    name = "Smartwatch";
                    price = 59999;
                    imageUrl = "Images/smartwatch.jpeg";
                    break;
                case 4:
                    name = "Wireless Earbuds";
                    price = 99999;
                    imageUrl = "Images/earbuds.jpeg";
                    break;
            }

            var cart = Session["Cart"] as List<CartItem> ?? new List<CartItem>();

            var existingItem = cart.Find(x => x.ProductId == productId);
            if (existingItem != null)
            {
                existingItem.Quantity++;
            }
            else
            {
                cart.Add(new CartItem
                {
                    ProductId = productId,
                    ProductName = name,
                    UnitPrice = price,
                    Quantity = 1,
                    ImageUrl = imageUrl  
                });
            }

            Session["Cart"] = cart;

            // Redirect to Cart page
            Response.Redirect("~/Cart.aspx");
        }
    }
}
