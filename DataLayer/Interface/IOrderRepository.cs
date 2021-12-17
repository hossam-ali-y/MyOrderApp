using DataLayer.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DataLayer.Interface
{
    public interface IOrderRepository
    {
        Task<ActionResult<IEnumerable<Order>>> GetOrders();
        Task<ActionResult<Order>> GetOrder(int id);

    }
}