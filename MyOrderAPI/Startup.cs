using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Formatters;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Data;
using DataLayer.Interface;
using DataLayer.Repository;

namespace MyOrderAPI
{
        public class Startup
        {
                public Startup(IConfiguration configuration)
                {
                        Configuration = configuration;
                }

                public IConfiguration Configuration { get; }

                // This method gets called by the runtime. Use this method to add services to the container.
                public void ConfigureServices(IServiceCollection services)
                {
                        services.AddHttpContextAccessor();
                        services.AddScoped<IProductRepository, ProductRepository>();
                        services.AddScoped<IOrderRepository, OrderRepository>();
                        services.AddScoped<ICartRepository, CartRepository>();

                        services.AddMvc(op => op.EnableEndpointRouting = false);
                        services.AddControllers();

                        // options =>  options.RespectBrowserAcceptHeader = true // false by default
                        services.AddControllers().AddNewtonsoftJson(options =>
                                                    {
                                                            //      var reslver = options.SerializerSettings.ContractResolver;
                                                            //      if (reslver != null)
                                                            //      (reslver as DefaultContractResolver).NamingStrategy = null;
                                                    });
                        services.AddSwaggerGen(c =>
                        {
                                c.SwaggerDoc("v1", new OpenApiInfo { Title = "MyOrderAPI", Version = "v1" });
                        });

                        services.AddDbContext<MyOrderDBContext>(options =>
                        {
                                options.UseSqlServer(Configuration.GetConnectionString("MyOrderDB"));
                        });
                        // services.AddControllers();

                        services.AddCors(options => options.AddPolicy("CorsPolicy", builder =>
                        {
                                builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
                        }));

                        services.AddSpaStaticFiles();

                        services.AddControllersWithViews(options =>
                                                            options.InputFormatters.Insert(0, GetJsonPatchInputFormatter())
                                              )
                                              .AddNewtonsoftJson(options =>
                                              options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
                                          );

                        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                            .AddJwtBearer(Options =>
                            {
                                    Options.TokenValidationParameters = new TokenValidationParameters
                                    {
                                            ValidateIssuerSigningKey = true,
                                            IssuerSigningKey = new SymmetricSecurityKey
                                            (Encoding.ASCII.GetBytes(Configuration.GetSection("AppSettings:Token").Value)),
                                            ValidateIssuer = false,
                                            ValidateAudience = false,

                                    };
                            });

                }

                private static NewtonsoftJsonPatchInputFormatter GetJsonPatchInputFormatter()
                {
                        var builder = new ServiceCollection()
                            .AddLogging()
                            .AddMvc()
                            .AddNewtonsoftJson()
                            .Services.BuildServiceProvider();

                        return builder
                            .GetRequiredService<IOptions<MvcOptions>>()
                            .Value
                            .InputFormatters
                            .OfType<NewtonsoftJsonPatchInputFormatter>()
                            .First();
                }

                // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
                public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
                {
                        if (env.IsDevelopment())
                        {
                                app.UseDeveloperExceptionPage();
                                app.UseSwagger();
                                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "MyOrderAPI v1"));
                        }

                        app.UseStaticFiles();
                        app.UseStaticFiles(new StaticFileOptions
                        {
                                FileProvider = new PhysicalFileProvider(
                                   Path.Combine(env.WebRootPath, "ClientApp")
                                   ),
                                DefaultContentType = "index.html",
                        });

                        // 
                        app.UseAuthentication();

                        app.UseMvc(routes =>
                        {
                                routes.MapRoute(
                                 name: "default",
                                 template: "{controller=Home}/{action=Index}/{id?}"
                                 );

                                routes.MapSpaFallbackRoute(
                                    name: "spa-fallback",
                                     defaults: new { controller = "Home", action = "Index" }
                                 );
                        });

                        app.UseHttpsRedirection();

                        app.UseRouting();
                        app.UseCors("CorsPolicy");

                        app.UseAuthorization();

                        app.UseEndpoints(endpoints =>
                        {
                                endpoints.MapControllers();
                        });
                }
        }
}
