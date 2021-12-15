﻿using System;
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
    public class CompaniesController : ControllerBase
    {
        private readonly MyOrderDBContext _context;

        public CompaniesController(MyOrderDBContext context)
        {
            _context = context;
        }

        // GET: api/Companies
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Company>>> GetCompanies()
        {
            return await _context.Companies.ToListAsync();
        }

        // GET: api/Companies/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Company>> GetCompany(int id)
        {
            var Company = await _context.Companies.FindAsync(id);

            if (Company == null)
            {
                return NotFound();
            }

            return Company;
        }

        // PUT: api/Companies/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCompany(int id, Company Company)
        {
            if (id != Company.Id)
            {
                return BadRequest();
            }

            _context.Entry(Company).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CompanyExists(id))
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

        // POST: api/Companies
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<Company>> PostCompany(Company Company)
        {
            _context.Companies.Add(Company);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCompany", new { id = Company.Id }, Company);
        }

        // DELETE: api/Companies/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Company>> DeleteCompany(int id)
        {
            var Company = await _context.Companies.FindAsync(id);
            if (Company == null)
            {
                return NotFound();
            }

            _context.Companies.Remove(Company);
            await _context.SaveChangesAsync();

            return Company;
        }

        private bool CompanyExists(int id)
        {
            return _context.Companies.Any(e => e.Id == id);
        }
    }
}
