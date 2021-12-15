using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace MyOrderAPI.Controllers
{
    public class HomeController : Controller
    {
        private readonly IHostingEnvironment _hostingEnvironment;

        public HomeController(IHostingEnvironment hostingEnvironment)
        {
            _hostingEnvironment = hostingEnvironment;
        }
        public IActionResult Index()
        {
            /*read content published angular index file */
            var indexfile = Path.Combine(_hostingEnvironment.WebRootPath, "ClientApp", "index.html");
            var indexContent = System.IO.File.ReadAllText(indexfile);
            return Content(indexContent, "text/html");
        }
    }
}
