using Hogar.HR.Domain.Enums;

namespace Hogar.HR.Domain.Responses;

public record ConfigurationUserResponse
(
    string CredentialId,
    string UserFullName,
    int ParameterId,
    string GroupName,
    string SubGroupName,
    string ParameterKey,
    string ValueParameter,
    DataTypesEnum ValueType,
    string ParameterDescription
);
