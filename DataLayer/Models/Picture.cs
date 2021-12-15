﻿
using System;
using System.Collections.Generic;

#nullable disable

namespace DataLayer.Models
{
    public partial class Picture
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string Picture1 { get; set; }
        public string Note { get; set; }

        public virtual Product Product { get; set; }
    }
}