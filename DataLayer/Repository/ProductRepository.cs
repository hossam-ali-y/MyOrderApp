using DataLayer.Data;
using DataLayer.Interface;
using DataLayer.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;

namespace DataLayer.Repository
{
        public class ProductRepository : IProductRepository
        {
                private readonly MyOrderDBContext _context;

                public ProductRepository(MyOrderDBContext context)
                {
                        _context = context;
                }

                public async Task<ActionResult<IEnumerable<Product>>> GetAllProducts()
                {
                        return await _context.Products.Include(e => e.Pictures).Include(e => e.Category)
                        .AsNoTracking().ToListAsync();
                }

        public async Task<ActionResult<IEnumerable<Product>>> GetProductsByCategory(int categoryId)
        {
            return await _context.Products.Include(e => e.Pictures).Include(e => e.Category)
                  .Where(e=>e.CategoryId==categoryId).AsNoTracking().ToListAsync();
        }


        public async Task<ActionResult<IEnumerable<Product>>> GetProductsSorted(string[] orderBy)
                {

                        var q = _context.Products.Include(e => e.Pictures).Include(e => e.Category)
                            .AsNoTracking();
                        q = q.OrderBy(orderBy[0]);

                        return await q.ToListAsync();
                }

        }
}