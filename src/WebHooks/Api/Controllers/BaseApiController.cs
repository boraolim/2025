using Microsoft.AspNetCore.Mvc;

using WebHooks.Api.Infrastructure.Filters;

namespace WebHooks.Api.Controllers;

[ApiController]
[ServiceFilter(typeof(ResilientActionFilter))]
[Route("api/v{version:apiVersion}/[controller]")]
public abstract class BaseApiController : ControllerBase { }
