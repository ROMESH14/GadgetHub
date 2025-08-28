using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GadgetHub.Models
{
    
        public class QuotationRequest
        {
            public int ProductId { get; set; }
            public int Quantity { get; set; } // ✅ Add this
        }


    public class QuotationResponse
    {
        public int ProductId { get; set; }
        public decimal UnitPrice { get; set; }
        public string DistributorName { get; set; }
        public int EstimatedDeliveryDays { get; set; }

        public int AvailableQuantity { get; set; } // ✅ Add this
    }
}

