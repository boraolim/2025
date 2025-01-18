using Hogar.HR.Domain.Entities;

namespace Hogar.HR.Application.Abstractions;

public interface IConfigurationRepository
{
    Task<bool> AddConfiguration(ConfigurationEntity itemToInsert);
    Task<bool> UpdateConfiguration(ConfigurationEntity itemToUpdate);
    Task<bool> EnableConfiguracionForGroup(ConfigurationEntity inputToUpdate, bool ShutDownValue);
    Task<bool> EnableConfiguracionForSubGroup(ConfigurationEntity inputToUpdate, bool ShutDownValue);
    Task<bool> EnableConfigurationForKeyName(ConfigurationEntity itemToUpdate, bool ShutDownValue);
    Task<List<ConfigurationEntity>> GetConfigurationByGroup(ConfigurationEntity inputEntity);
    Task<List<ConfigurationEntity>> GetConfigurationBySubGroup(ConfigurationEntity inputEntity);
    Task<ConfigurationEntity> GetConfigurationByKeyName(ConfigurationEntity inputEntity);
}
