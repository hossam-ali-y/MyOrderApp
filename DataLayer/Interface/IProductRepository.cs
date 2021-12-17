using DataLayer.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DataLayer.Interface
{
        public interface IProductRepository
        {
                Task<ActionResult<IEnumerable<Product>>> GetAllProducts();
        Task<ActionResult<IEnumerable<Product>>> GetProductsByCategory(int categoryId);

        Task<ActionResult<IEnumerable<Product>>> GetProductsSorted(string[] orderBy);

        }
}