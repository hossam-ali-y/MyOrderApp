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
    public class CartItemsController : ControllerBase
    {
        private readonly MyOrderDBContext _context;

        public CartItemsController(MyOrderDBContext context)
        {
            _context = context;
        }

        // GET: api/Carts
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CartItem>>> GetCartItems()
        {
            return await _context.CartItems.ToListAsync();
        }

        // GET: api/CartItems/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CartItem>> GetCartItem(int id)
        {
            var CartItem = await _context.CartItems.FindAsync(id);

            if (CartItem == null)
            {
                return NotFound();
            }

            return CartItem;
        }

        // PUT: api/CartItems/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCartItem(int id, CartItem CartItem)
        {
            if (id != CartItem.Id)
            {
                return BadRequest();
            }

            _context.Entry(CartItem).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CartItemExists(id))
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

        // POST: api/CartItems
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<CartItem>> PostCartItem(CartItem CartItem)
        {
            _context.CartItems.Add(CartItem);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCartItem", new { id = CartItem.Id }, CartItem);
        }

        // DELETE: api/CartItems/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<CartItem>> DeleteCartItem(int id)
        {
            var CartItem = await _context.CartItems.FindAsync(id);
            if (CartItem == null)
            if (CartItem == null)
            {
                return NotFound();
            }

            _context.CartItems.Remove(CartItem);
            await _context.SaveChangesAsync();

            return CartItem;
        }

        private bool CartItemExists(int id)
        {
            return _context.CartItems.Any(e => e.Id == id);
        }
    }
}
