using Microsoft.AspNetCore.Mvc;

namespace TestContainerApp.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SomeApiCallController : ControllerBase
    {
        private const string _apiVersion = "v1";
            private readonly ILogger<SomeApiCallController> _logger;
        const int _delayCount = 10;

        public SomeApiCallController(ILogger<SomeApiCallController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetSomeApiResult")]
        public ApiResultModel Get()
        {
            Console.WriteLine("Received request: {0}", DateTime.UtcNow.ToString("yyyy-MM-dd hh:mm:ss"));
            for (var i=0; i < _delayCount; i++)
            {
                // Execute a tight loop for CPU usage
            }
            return new ApiResultModel
            {
                DateTime = DateTime.UtcNow,
                Version = _apiVersion
            };
        }
    }
}