using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DataLayer.Data;
using DataLayer.Models;
using Microsoft.AspNetCore.Cors;
using System.Linq.Dynamic.Core;
using DataLayer.Interface;

namespace MyOrderAPI.Controllers
{
        // [Authorize]
        [Route("api/[controller]")]
        [ApiController]
        [EnableCors("CorsPolicy")]

        public class ProductsController : ControllerBase
        {
                private readonly MyOrderDBContext _context;
                private readonly IProductRepository _productRepository;

                public ProductsController(MyOrderDBContext context, IProductRepository productRepository)
                {
                        _context = context;
                        _productRepository = productRepository;
                }

                // GET: api/Products
                [HttpGet]
                public async Task<ActionResult<IEnumerable<Product>>> GetProducts()
                {
                        return await _productRepository.GetAllProducts();
                }

        // GET: api/Products/byCategory
        [HttpGet("byCategory/{categoryId}")]
        public async Task<ActionResult<IEnumerable<Product>>> GetProductsByCategory(int categoryId)
        {
            return await _productRepository.GetProductsByCategory(categoryId);
        }

        // GET: api/Products
        [HttpPost("sort")]
                public async Task<ActionResult<IEnumerable<Product>>> GetProductsSorted(string[] orderBy)
                {
                        return await _productRepository.GetProductsSorted(orderBy);
                }

                // GET: api/Products/5
                [HttpGet("{id}")]
                public async Task<ActionResult<Product>> GetProduct(int id)
                {
                        var Product = await _context.Products.FindAsync(id);

                        if (Product == null)
                        {
                                return NotFound();
                        }

                        return Product;
                }

                // PUT: api/Products/5
                // To protect from overposting attacks, enable the specific properties you want to bind to, for
                // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
                [HttpPut("{id}")]
                public async Task<IActionResult> PutProduct(int id, Product Product)
                {
                        if (id != Product.Id)
                        {
                                return BadRequest();
                        }

                        _context.Entry(Product).State = EntityState.Modified;

                        try
                        {
                                await _context.SaveChangesAsync();
                        }
                        catch (DbUpdateConcurrencyException)
                        {
                                if (!ProductExists(id))
                                {
                                        return NotFound();
                                }
                                else
                                {
                                        throw;
                                }
                        }

                        return NoContent();
                }

                // POST: api/Products
                // To protect from overposting attacks, enable the specific properties you want to bind to, for
                // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
                [HttpPost]
                public async Task<ActionResult<Product>> PostProduct(Product Product)
                {
                        _context.Products.Add(Product);
                        await _context.SaveChangesAsync();

                        return CreatedAtAction("GetProduct", new { id = Product.Id }, Product);
                }

                // DELETE: api/Products/5
                [HttpDelete("{id}")]
                public async Task<ActionResult<Product>> DeleteProduct(int id)
                {
                        var Product = await _context.Products.FindAsync(id);
                        if (Product == null)
                        {
                                return NotFound();
                        }

                        _context.Products.Remove(Product);
                        await _context.SaveChangesAsync();

                        return Product;
                }

                private bool ProductExists(int id)
                {
                        return _context.Products.Any(e => e.Id == id);
                }
        }
}
