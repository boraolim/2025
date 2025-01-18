using MediatR;

using Core.Domain.Abstractions;

namespace WebHooks.Domain.Requests;

public class GreetingRequest : IRequest<string>
{
    public string NamePerson { get; set; }
}
