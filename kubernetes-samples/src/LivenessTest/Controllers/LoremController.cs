using System.Net;

using Microsoft.AspNetCore.Mvc;

using LivenessTest.Services;

namespace LivenessTest.Controllers;

[ApiController]
[Route("api/[controller]")]
public class LoremController : ControllerBase {
    private readonly LoremService _loremService;

    public LoremController(LoremService loremService) {
        _loremService = loremService;
    }

    [HttpGet]
    public ActionResult<string> Get() {
        try {
            var localIp = Request.HttpContext.Connection.LocalIpAddress;
            var loremText = _loremService.GetSentence();
            return $"{Environment.MachineName} ({localIp}){Environment.NewLine}{loremText}";
        } catch (Exception) {
            return new StatusCodeResult((int) HttpStatusCode.ServiceUnavailable);
        }
    }
}
