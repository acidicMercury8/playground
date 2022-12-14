using System.Reflection;

using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

using SwaggerWebApplication.Models;

namespace SwaggerWebApplication;

public class Program {
    public static async Task Main(string[] args) {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container
        builder.Services.AddDbContext<TodoContext>(options =>
            options.UseInMemoryDatabase("Todo"));
        builder.Services.AddControllers();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen(options => {
            options.SwaggerDoc("v1", new OpenApiInfo {
                Version = "v1",
                Title = "ToDo API",
                Description = "ASP.NET Core Web API for testing Swagger features",
                TermsOfService = new Uri("https://localhost:5001/terms"),
                Contact = new OpenApiContact {
                    Name = "Example Contact",
                    Url = new Uri("https://localhost:5001/contact")
                },
                License = new OpenApiLicense {
                    Name = "Example License",
                    Url = new Uri("https://localhost:5001/license")
                },
            });

            var xmlFileName = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
            options.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, xmlFileName));
        });

        var app = builder.Build();

        // Configure the HTTP request pipeline
        if (app.Environment.IsDevelopment()) {
            app.UseSwagger(/*options => {
                options.SerializeAsV2 = true;
            }*/);
            app.UseSwaggerUI(/*options => {
                options.SwaggerEndpoint("/swagger/v1/swagger.json", "v1");
                options.RoutePrefix = string.Empty;
                //options.InjectStylesheet("/swagger-ui/custom.css");
            }*/);
        }

        app.UseHttpsRedirection();
        //app.UseStaticFiles();
        app.UseAuthorization();

        app.MapControllers();

        using (var serviceScope = app.Services.CreateScope()) {
            var context = serviceScope.ServiceProvider.GetRequiredService<TodoContext>();
            context.TodoItems.Add(new TodoItem { Name = "Item #1" });
            await context.SaveChangesAsync();
        }

        app.Run();
    }
}
