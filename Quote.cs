using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GadgetHub.Models
{
    
        public class Quote
        {
            public string DistributorName { get; set; }
            public decimal Price { get; set; }
            public bool InStock { get; set; }
            public int EstimatedDeliveryDays { get; set; }

            public decimal TotalPrice { get; set; } // ✅ Add this if you're referencing it


            public string InStockText => InStock ? " In Stock" : " Out of Stock";

        }
    }

    

