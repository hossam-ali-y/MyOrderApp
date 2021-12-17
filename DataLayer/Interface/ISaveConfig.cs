using System;

namespace DataLayer.Interface
{
        public interface ISaveConfig
        {

                public DateTime? CreateDate { get; set; }
                public static DateTime? ModifiedDate { get; set; }

        }
}