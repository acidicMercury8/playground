using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Negotiate;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BasicAuthenticationWebApi.Controllers;

[AllowAnonymous]
[ApiController]
[Route("[controller]")]
public class LoginController : ControllerBase
{
    [HttpGet(Name = "Get")]
    public IActionResult Get()
    {
        return Challenge(
            new AuthenticationProperties
            {
                RedirectUri = "/WeatherForecast"
            },
            NegotiateDefaults.AuthenticationScheme
        );
    }
}
