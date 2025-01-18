using System.Text.Json.Serialization;

using Hogar.HR.Domain.Enums;
using Core.Utils.Converters;
using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Domain.Requests;

public record GroupRequest
(
    string GroupName
) : IRequest<List<ConfigurationResponse>>;

public record SubGroupRequest
(
    string GroupName,
    string SubGroupName
) : IRequest<List<ConfigurationResponse>>;

public record KeyNameRequest
(
    string GroupName,
    string SubGroupName,
    string KeyName
) : IRequest<ConfigurationResponse>;

public record AddKeyValueRequest
(
    string GroupName,
    string SubGroupName,
    string KeyName,
    string KeyValue,
    [property: JsonConverter(typeof(EnumJsonConverter<DataTypesEnum>))]
    DataTypesEnum ValueType,
    string Comments
) : IRequest<bool>;

public record EnableGroupRequest
(
    string GroupName,
    bool ShutDownValue
) : IRequest<bool>;

public record EnableSubGroupRequest
(
    string GroupName,
    string SubGroupName,
    bool ShutDownValue
) : IRequest<bool>;

public record EnableKeyNameRequest
(
    string GroupName,
    string SubGroupName,
    string KeyName,
    bool ShutDownValue
) : IRequest<bool>;

public record UpdateKeyValueRequest
(
    string GroupName,
    string SubGroupName,
    string KeyName,
    string KeyValue,
    [property: JsonConverter(typeof(EnumJsonConverter<DataTypesEnum>))]
    DataTypesEnum ValueType,
    string Comments
) : IRequest<bool>;
