using Core.Utils.Functions;
using Hogar.HR.Domain.Requests;

using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsLocal = Hogar.HR.Domain.Constants.MessageConstants;

namespace Hogar.HR.Application.Validators;

public sealed class RegisterValidator : AbstractValidator<RegisterRequest>
{
    public RegisterValidator()
    {
        ClassLevelCascadeMode = CascadeMode.Stop;

        RuleFor(x => x.Username).Cascade(CascadeMode.Stop)
            .Must(item => !string.IsNullOrWhiteSpace(item)).WithMessage(MessageConstantsLocal.MSG_USER_NAME_REQUIRED)
            .Must(item => Regex.IsMatch(item, RegexConstantsCore.RGX_USERNAME_PATTERN)).WithMessage(MessageConstantsLocal.MSG_USER_NAME_MALFORMED);

        RuleFor(x => x.Password).Cascade(CascadeMode.Stop)
            .Must(item => !string.IsNullOrWhiteSpace(item)).WithMessage(MessageConstantsLocal.MSG_PASSWORD_REQUIRED)
            .Must(item => Functions.IsValidPassword(item)).WithMessage(MessageConstantsLocal.MSG_PASSWORD_MALFORMED);

        RuleFor(x => x.Fullname).Cascade(CascadeMode.Stop)
            .Must(item => !string.IsNullOrWhiteSpace(item)).WithMessage(MessageConstantsLocal.MSG_FULLNAME_REQUIRED)
            .Must(item => Regex.IsMatch(item, RegexConstantsCore.RGX_ALPHA_PATTERN)).WithMessage(MessageConstantsLocal.MSG_FULLNAME_MALFORMED);
    }
}
