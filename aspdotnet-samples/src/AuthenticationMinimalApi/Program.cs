using System.Security.Claims;

using Microsoft.AspNetCore.Authentication;

var builder = WebApplication.CreateBuilder(args);

//builder.Services.AddDataProtection();
//builder.Services.AddHttpContextAccessor();
//builder.Services.AddScoped<AuthService>();

builder.Services.AddAuthentication("cookie")
    .AddCookie("cookie");

var app = builder.Build();

//app.Use((context, next) => {
//    var provider = context.RequestServices.GetRequiredService<IDataProtectionProvider>();
//    var protector = provider.CreateProtector("auth-cookie");

//    var authCookie = context.Request.Headers.Cookie.FirstOrDefault(x => x.StartsWith("auth="));
//    var protectedPayload = authCookie?.Split("=").Last();
//    var payload = protector.Unprotect(protectedPayload);
//    var parts = payload?.Split(';');
//    var key = parts[0];
//    var value = parts[1];

//    var claims = new List<Claim> {
//        new Claim(key, value)
//    };
//    var identity = new ClaimsIdentity(claims);
//    context.User = new ClaimsPrincipal(identity);

//    return next();
//});

app.UseAuthentication();

app.MapGet("/username", (HttpContext context) => {
    return context.User?.FindFirst("usr")?.Value;
});

app.MapGet("/login", async (HttpContext context) => {
    //service.SignIn();

    var claims = new List<Claim> {
        new Claim("usr", "username")
    };
    var identity = new ClaimsIdentity(claims, "cookie");
    var user = new ClaimsPrincipal(identity);

    await context.SignInAsync("cookie", user);
    return "ok";
});

app.Run();

//public class AuthService {
//    private readonly IDataProtectionProvider _provider;
//    private readonly IHttpContextAccessor _accessor;

//    public AuthService(IDataProtectionProvider provider, IHttpContextAccessor accessor) {
//        _provider = provider;
//        _accessor = accessor;
//    }

//    public void SignIn() {
//        var protector = _provider.CreateProtector("auth-cookie");
//        _accessor.HttpContext.Response.Headers["set-cookie"] = $"auth={protector.Protect("usr:username")}";
//    }
//}
