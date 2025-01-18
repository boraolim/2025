using Hogar.HR.Domain.Entities;

namespace Hogar.HR.Application.Abstractions;

public interface IManagementRepository
{
    #region "ConfigurationUser"

    Task<bool> AddNewParameterUser(ConfigurationUserEntity itemToInsert, string jsonString);
    Task<bool> UpdateParameterUser(ConfigurationUserEntity itemToUpdate, string jsonString);
    Task<bool> LockAllParameterToUser(ConfigurationUserEntity itemToUpdate);
    Task<bool> DisableAllParameterToUser(ConfigurationUserEntity itemToDelete);
    Task<bool> EnableAllParameterToUser(ConfigurationUserEntity itemToUpdate);
    Task<List<ConfigurationUserEntity>> GetParameterUser(ConfigurationUserEntity inputEntity);

    #endregion

    Task<bool> AddPolicyToUser(PolicyUserEntity Input);
    Task<bool> LockAllPolicyToUser(PolicyUserEntity Input);
    Task<bool> DisableAllPolicyToUser(PolicyUserEntity Input);
    Task<bool> EnableAllPolicyToUser(PolicyUserEntity Input);
    Task<List<PolicyUserEntity>> GetPolicyUser(string CredentialId);
    Task<List<ModuleEntity>> GetAllModules();
    Task<List<ModuleEntity>> GetExistentModule(int moduleId);
    Task<bool> AddNewModule(ModuleEntity Input);
    Task<bool> UpdateNewModule(ModuleEntity Input);
    Task<bool> DeleteExistentModule(ModuleEntity Input);
    Task<List<PolicyEntity>> GetAllPolicies();
    Task<List<PolicyEntity>> GetExistentPolicy(int PolicyId);
    Task<bool> AddNewPolicy(PolicyEntity Input);
    Task<bool> UpdateExistentPolicy(PolicyEntity Input);
    Task<bool> DeleteExistentPolicy(PolicyEntity Input);
    Task<bool> AddNewModulePolicy(ModulePolicyEntity Input);
    Task<bool> DeleteModulePolicy(ModulePolicyEntity Input);
    Task<List<ModulePolicyEntity>> GetAllModulePolicy();
    Task<List<ModulePolicyEntity>> GetModulePolicy(int ModulePolicyId);
    Task<bool> AddUserModulePolicy(PolicyUserEntity Input);
    Task<bool> DeleteUserModulePolicy(PolicyUserEntity Input);
    Task<List<PolicyUserEntity>> GetAllUserModulePolicies();
    Task<List<PolicyUserEntity>> GetUserModulePolicies(int UserPolicyId);
}
