﻿using System;
using System.Collections.Generic;

#nullable disable

namespace DataLayer.Models
{
    public partial class Company
    {
        public Company()
        {
            Products = new HashSet<Product>();
        }

        public int Id { get; set; }
        public string CompanyName { get; set; }
        public string Address { get; set; }
        public string Owner { get; set; }
        public string Manager { get; set; }
        public string OwnerPhone { get; set; }
        public string ManagerPhone { get; set; }
        public string Logo { get; set; }
        public DateTime? OpeningDate { get; set; }
        public DateTime? ClosingDate { get; set; }

        public virtual ICollection<Product> Products { get; set; }
    }
}