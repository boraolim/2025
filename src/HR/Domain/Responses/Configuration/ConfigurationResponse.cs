using Core.Domain.Common;
using Hogar.HR.Domain.Enums;

namespace Hogar.HR.Domain.Responses;

public record ConfigurationResponse
(
    int Id,
    string GroupName,
    string SubGroupName,
    string KeyName,
    string KeyValue,
    DataTypesEnum ValueType,
    string KeyDescription
);
