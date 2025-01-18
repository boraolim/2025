using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Application.Abstractions;

public interface IConfigurationService
{
    Task<bool> EnableGroup(EnableGroupRequest request);
    Task<bool> EnableKeyName(EnableKeyNameRequest request);
    Task<bool> EnableSubGroup(EnableSubGroupRequest request);
    Task<List<ConfigurationResponse>> GetConfigurationByGroup(GroupRequest request);
    Task<List<ConfigurationResponse>> GetConfigurationBySubGroup(SubGroupRequest request);
    Task<ConfigurationResponse> GetKeyName(KeyNameRequest request);
    Task<bool> SaveKeyValue(AddKeyValueRequest request);
    Task<bool> UpdateKeyValue(UpdateKeyValueRequest request);
}
