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

namespace MyOrderAPI.Controllers
{
        // [Authorize]
        [Route("api/[controller]")]
        [ApiController]
        [EnableCors("CorsPolicy")]
        public class CategoriesController : ControllerBase
        {
                private readonly MyOrderDBContext _context;

                public CategoriesController(MyOrderDBContext context)
                {
                        _context = context;
                }

                // GET: api/Categories
                [HttpGet]
                public async Task<ActionResult<IEnumerable<Category>>> GetCategories()
                {
                        return await _context.Categories.ToListAsync();
                }

                // GET: api/Categories/5
                [HttpGet("{id}")]
                public async Task<ActionResult<Category>> GetCategory(int id)
                {
                        var Category = await _context.Categories.FindAsync(id);

                        if (Category == null)
                        {
                                return NotFound();
                        }

                        return Category;
                }

                // PUT: api/Categories/5
                // To protect from overposting attacks, enable the specific properties you want to bind to, for
                // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
                [HttpPut("{id}")]
                public async Task<IActionResult> PutCategory(int id, Category Category)
                {
                        if (id != Category.Id)
                        {
                                return BadRequest();
                        }

                        _context.Entry(Category).State = EntityState.Modified;

                        try
                        {
                                await _context.SaveChangesAsync();
                        }
                        catch (DbUpdateConcurrencyException)
                        {
                                if (!CategoryExists(id))
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

                // POST: api/Categories
                // To protect from overposting attacks, enable the specific properties you want to bind to, for
                // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
                [HttpPost]
                public async Task<ActionResult<Category>> PostCategory(Category Category)
                {
                        _context.Categories.Add(Category);
                        await _context.SaveChangesAsync();

                        return CreatedAtAction("GetCategory", new { id = Category.Id }, Category);
                }

                // DELETE: api/Categories/5
                [HttpDelete("{id}")]
                public async Task<ActionResult<Category>> DeleteCategory(int id)
                {
                        var Category = await _context.Categories.FindAsync(id);
                        if (Category == null)
                        {
                                return NotFound();
                        }

                        _context.Categories.Remove(Category);
                        await _context.SaveChangesAsync();

                        return Category;
                }

                private bool CategoryExists(int id)
                {
                        return _context.Categories.Any(e => e.Id == id);
                }
        }
}
