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
    public class OrderRepository:IOrderRepository
    {
        private readonly MyOrderDBContext _context;

        public OrderRepository(MyOrderDBContext context)
        {
            _context = context;
        }

        public async Task<ActionResult<IEnumerable<Order>>> GetOrders()
        {
            return await _context.Orders.Include(e=>e.CartItems).ThenInclude(e=>e.Product)
                                     .ThenInclude(e => e.Pictures).OrderByDescending(e=>e.Id)
                                     .AsNoTracking().ToListAsync();
        }

        public async Task<ActionResult<Order>> GetOrder(int id)
        {
            var Order = await _context.Orders.Include(e => e.CartItems).ThenInclude(e => e.Product)
                                     .ThenInclude(e => e.Pictures).OrderByDescending(e => e.Id)
                                     .AsNoTracking().FirstOrDefaultAsync(e=>e.Id==id);

            return Order;
        }


    }
}