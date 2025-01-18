using Hogar.HR.Api.Infrastructure.Filters;

namespace Hogar.HR.Api.Controllers;

[ApiController]
[ServiceFilter(typeof(ResilientActionFilter))]
[Route("api/v{version:apiVersion}/[controller]")]
public abstract class BaseApiController : ControllerBase { }
