using System.Text.Json;

using Ardalis.GuardClauses;
using Microsoft.Extensions.Options;

using Core.Domain.Common;
using Core.Utils.Functions;
using KeyGenerator.Settings;
using KeyGenerator.Abstractions;
using Core.Application.Abstractions.Helpers;
using Core.Application.Abstractions.Security;

namespace KeyGenerator.Implementations;

public class MainService : IMainService
{
    private readonly AppSettings _settings;
    private readonly ICypherAes _cypherAes;
    private readonly IJwtService _jwtService;

    public MainService(IOptions<AppSettings> options,
                       ICypherAes cypherAes) =>
        (_settings, _cypherAes) = (Guard.Against.Null(options).Value, Guard.Against.Null(cypherAes));

    public async Task DoActionSomethingAsync()
    {
        await Task.Run(() =>
        {
            var environmentReader = _settings.VariableEntorno.CheckIsNull() ?
                            Functions.GenerateRandomString(512) : _settings.VariableEntorno;
            var hashes = Functions.GenerateHash512(environmentReader);

            var gcmKey = new string(hashes.HexHash.Skip(32).Take(32).ToArray());

            // Obtener un json que guarde valores de JWT cifrados.
            var dataBaseUrl = Functions.GenerateRandomString(256);
            var rootPassword = Functions.GenerateRandomString(40);
            var clientSecret = Functions.GenerateRandomString(40);
            var issuerValue = Functions.GenerateRandomString(40);
            var audienceValue = Functions.GenerateRandomString(40);

            var newJwt = new
            {
                MainSecretEnv = new string(hashes.HexHash.ToArray()),
                DataBaseUrl = _cypherAes.AESEncryptionGCM(_settings.ConexionBaseDatos),
                RootPassword = _cypherAes.AESEncryptionGCM(rootPassword),
                ClientSecretKey = _cypherAes.AESEncryptionGCM(clientSecret),
                Issuer = _cypherAes.AESEncryptionGCM(issuerValue),
                Audience = _cypherAes.AESEncryptionGCM(audienceValue)
            };

            var jsonFinal = JsonSerializer.Serialize(newJwt, new JsonSerializerOptions { WriteIndented = true });
            var finalJsonFile = Path.Combine(Directory.GetCurrentDirectory(), $"Cfg_{Functions.GenerateRandomString(30)}.json");
            Console.WriteLine($"Configuración final generada:\n{jsonFinal}");
            
            // Escribir el JSON en el archivo
            File.WriteAllText(finalJsonFile, jsonFinal);

            Console.WriteLine($"Configuraciones de la web api guardadas correctamente en: {finalJsonFile}");
        }).ConfigureAwait(false);
    }
}
