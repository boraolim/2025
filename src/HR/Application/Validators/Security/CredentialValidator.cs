using Core.Utils.Functions;
using Hogar.HR.Domain.Requests;

using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsLocal = Hogar.HR.Domain.Constants.MessageConstants;

namespace Hogar.HR.Application.Validators;

public sealed class CredentialValidator : AbstractValidator<CredentialRequest>
{
    public CredentialValidator()
    {
        RuleFor(x => x.UserName).Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(MessageConstantsLocal.MSG_USER_NAME_REQUIRED)
            .Matches(RegexConstantsCore.RGX_USERNAME_PATTERN).WithMessage(MessageConstantsLocal.MSG_USER_NAME_MALFORMED);
        RuleFor(x => x.PasswordValue).Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(MessageConstantsLocal.MSG_PASSWORD_REQUIRED)
            .Must(item => Functions.IsValidPassword(item)).WithMessage(MessageConstantsLocal.MSG_PASSWORD_MALFORMED);
    }
}
