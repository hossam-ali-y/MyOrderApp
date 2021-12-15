﻿
using System;
using System.Collections.Generic;

#nullable disable

namespace DataLayer.Models
{
    public partial class Product
    {
        public Product()
        {
            Carts = new HashSet<Cart>();
            Pictures = new HashSet<Picture>();
        }

        public int Id { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int? CategoryId { get; set; }
        public int Quantity { get; set; }
        public int? CompanyId { get; set; }

        public virtual Category Category { get; set; }
        public virtual Company Company { get; set; }
        public virtual ICollection<Cart> Carts { get; set; }
        public virtual ICollection<Picture> Pictures { get; set; }
    }
}