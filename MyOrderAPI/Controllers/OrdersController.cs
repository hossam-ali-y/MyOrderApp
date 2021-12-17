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
using DataLayer.Interface;

namespace MyOrderAPI.Controllers
{
    // [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("CorsPolicy")]
    public class OrdersController : ControllerBase
    {
        private readonly MyOrderDBContext _context;
        private readonly IOrderRepository _orederRepository;

        public OrdersController(MyOrderDBContext context,IOrderRepository orederRepository)
        {
            _context = context;
           _orederRepository = orederRepository;
        }

        // GET: api/Orders
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Order>>> GetOrders()
        {
            return await _orederRepository.GetOrders();
        }

        // GET: api/Orders/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Order>> GetOrder(int id)
        {
            var Order = await _orederRepository.GetOrder(id);

            if (Order == null)
            {
                return NotFound();
            }

            return Order;
        }

        // PUT: api/Orders/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<ActionResult> PutOrder(int id, Order Order)
        {
            if (id != Order.Id)
            {
                return BadRequest();
            }

            _context.Entry(Order).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrderExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            var order = await _orederRepository.GetOrder(id);

            return Ok(order);
        }

        // POST: api/Orders
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<Order>> PostOrder(Order Order)
        {
            Console.WriteLine(Order.CartItems.Count());
            _context.Orders.Add(Order);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetOrder", new { id = Order.Id }, Order);
        }

        // DELETE: api/Orders/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Order>> DeleteOrder(int id)
        {
            var Order = await _context.Orders.Include(e=>e.CartItems).FirstOrDefaultAsync(e=>e.Id==id);
            if (Order == null)
            {
                return NotFound();
            }


            _context.Orders.RemoveRange(Order);
            await _context.SaveChangesAsync();

            return Order;
        }

        private bool OrderExists(int id)
        {
            return _context.Orders.Any(e => e.Id == id);
        }
    }
}
