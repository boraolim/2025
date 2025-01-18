using WebHooks.Domain.Requests;

using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsLocal = WebHooks.Domain.Constants.MessageConstants;

namespace WebHooks.Application.Validators;

public sealed class GrettingValidator : AbstractValidator<GreetingRequest>
{
    public GrettingValidator()
    {
        ClassLevelCascadeMode = CascadeMode.Stop;

        RuleFor(x => x.NamePerson).Cascade(CascadeMode.Stop)
            .Must(item => !string.IsNullOrWhiteSpace(item)).WithMessage(MessageConstantsLocal.MSG_NAME_REQUIRED)
            .Must(item => Regex.IsMatch(item, RegexConstantsCore.RGX_USERNAME_PATTERN)).WithMessage(MessageConstantsLocal.MSG_NAME_MALFORMED);
    }
}
