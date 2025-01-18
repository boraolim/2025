using Core.Utils.CustomExceptions;

namespace Core.Application.Behaviours
{
    public sealed class ValidationBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
        where TRequest : notnull
    {
        private readonly IEnumerable<IValidator<TRequest>> _validator;
        public ValidationBehaviour(IEnumerable<IValidator<TRequest>> validator) => 
            _validator = Guard.Against.Null(validator);

        public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
        {
            if (_validator.Any())
            {
                var contextValidation = new ValidationContext<TRequest>(request);
                var validationResults = await Task.WhenAll(_validator.Select(itemVal => itemVal.ValidateAsync(contextValidation, cancellationToken)));
                var failures = validationResults
                    .Where(itemErr => itemErr.Errors.Any())
                    .SelectMany(dataField => dataField.Errors)
                    .ToList();

                if (failures.Any())
                    throw new CommonValidationException(failures);
            }

            return await next();
        }
    }
}
