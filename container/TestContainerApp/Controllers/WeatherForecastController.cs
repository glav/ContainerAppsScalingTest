using Microsoft.AspNetCore.Mvc;

namespace TestContainerApp.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SomeApiCallController : ControllerBase
    {
        private const string _apiVersion = "v1";
            private readonly ILogger<SomeApiCallController> _logger;

        public SomeApiCallController(ILogger<SomeApiCallController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetSomeApiResult")]
        public ApiResultModel Get()
        {
            return new ApiResultModel
            {
                DateTime = DateTime.UtcNow,
                Version = _apiVersion
            };
        }
    }
}