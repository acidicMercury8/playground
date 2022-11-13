using LivenessTest.Services;

using Microsoft.AspNetCore.Hosting;

namespace LivenessTest;

public class Program {
    private static readonly int _port = 80;
    private static readonly TimeSpan _timeout = TimeSpan.FromSeconds(1);

    public static void Main(string[] args) {
        var builder = WebApplication.CreateBuilder(args);

        builder.WebHost.ConfigureKestrel(serverOptions => {
            serverOptions.ListenAnyIP(_port);
            serverOptions.Limits.KeepAliveTimeout = _timeout;
        });
        builder.WebHost.UseUrls();

        // Add services to the container
        builder.Services.AddSingleton<LoremService>();

        builder.Services.AddControllers();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();

        var app = builder.Build();

        // Configure the HTTP request pipeline
        if (app.Environment.IsDevelopment()) {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseHttpsRedirection();
        app.UseAuthorization();

        app.MapControllers();

        app.Run();
    }
}
