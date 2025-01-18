using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Utils.CustomExceptions;

public class CommonValidationException : Exception
{
    public List<ValidationFailure> errors { get; }
    public CommonValidationException(IEnumerable<ValidationFailure> failures)
        : base(MessageConstantsCore.MSG_FAIL_VALIDATION) => errors = failures.ToList();
}
