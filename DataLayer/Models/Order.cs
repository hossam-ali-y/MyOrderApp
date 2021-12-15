﻿
using System;
using System.Collections.Generic;

#nullable disable

namespace DataLayer.Models
{
    public partial class Order
    {
        public Order()
        {
            Carts = new HashSet<Cart>();
        }

        public int Id { get; set; }
        public string CustomerName { get; set;}
        public string CustomerEmail { get; set; }
        public string CustomerPhone { get; set; }
        public int Status { get; set; }
        public string Note { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? ShippedDate { get; set; }
        public DateTime? DeliveredDate { get; set; }
        public decimal TotalPrice { get; set; }

        public virtual ICollection<Cart> Carts { get; set; }
    }
}