using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Domain.Requests;

public record AddConfigurationUserRequest
(
    string CredentialId,
    List<ParameterIdRequest> ConfigurationIdList
) : IRequest<bool>;

public record UpdateConfigurationUserRequest
(
    string CredentialId,
    List<ParameterIdRequest> ConfigurationIdList
) : IRequest<bool>;

public record ParameterIdRequest
(
    int idParameter
) : IRequest<bool>;

public record LockConfigurationUserRequest
(
    string CredentialId
) : IRequest<bool>;

public record DisableConfigurationUserRequest
(
    string CredentialId
) : IRequest<bool>;

public record EnableConfigurationUserRequest
(
    string CredentialId
) : IRequest<bool>;

public record ActionConfigurationUserRequest
(
    string CredentialId
) : IRequest<List<ConfigurationUserResponse>>;
