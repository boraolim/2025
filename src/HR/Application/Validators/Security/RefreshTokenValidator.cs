using Hogar.HR.Domain.Requests;

using MessageConstantsLocal = Hogar.HR.Domain.Constants.MessageConstants;

namespace Hogar.HR.Application.Validators;

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
