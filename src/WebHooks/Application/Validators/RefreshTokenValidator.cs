using System.Text.RegularExpressions;

using FluentValidation;

using Core.Application.Utils;
using WebHooks.Domain.Requests;

using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsLocal = WebHooks.Domain.Constants.MessageConstants;

namespace WebHooks.Application.Validators;

public sealed class RefreshTokenValidator : AbstractValidator<RefreshRequest>
{
    public RefreshTokenValidator()
    {
        RuleFor(x => x.AccessToken).Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(MessageConstantsLocal.MSG_ACCESS_TOKEN_REQUIRED);
        RuleFor(x => x.RefreshToken).Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(MessageConstantsLocal.MSG_REFRESH_TOKEN_REQUIRED);
    }
}
