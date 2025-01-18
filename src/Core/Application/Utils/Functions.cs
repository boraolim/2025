using System.Data;
using System.Text;
using System.Reflection;
using System.Security.Cryptography;
using System.Text.RegularExpressions;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Application.Utils;

public static class Functions
{
    public static string GenerateRandomString(int sizeLength)
    {
        const string allowedChars = MainConstantsCore.CFG_ALPHA_COLLECTION;
        var result = new StringBuilder();

        var random = new Random();
        for(var i = 0; i < sizeLength; i++)
        {
            var index = random.Next(allowedChars.Length);
            result.Append(allowedChars[index]);
        }

        return result.ToString();
    }

    public static IEnumerable<R> DataReaderMapToListAsync<R>(IDataReader drReader)
    {
        if(drReader == null)
            throw new ArgumentNullException(nameof(drReader));

        return DataReaderMapToListIteratorAsync<R>(drReader).ToList();
    }

    public static IEnumerable<R> PaginateData<R>(this List<R> dataSet, int pageNumber, int pageSize) =>
        dataSet.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();

    public static string StringToHex(string inputString)
    {
        byte[] bytesInput = Encoding.UTF8.GetBytes(inputString);

        StringBuilder hexBuilder = new StringBuilder(bytesInput.Length * 2);

        foreach(byte byteString in bytesInput)
            hexBuilder.AppendFormat("{0:x2}", byteString);

        return hexBuilder.ToString().ToUpper();
    }

    public static byte[] HexToString(string inputHex)
    {
        if(inputHex.Length % 2 != 0)
            throw new ArgumentException(MessageConstantsCore.MSG_PAIR_EXACTLY);

        var bytesHex = new byte[inputHex.Length / 2];

        for(int i = 0; i < bytesHex.Length; i++)
        {
            string byteValue = inputHex.Substring(i * 2, 2);
            bytesHex[i] = Convert.ToByte(byteValue, 16);
        }

        return bytesHex;
    }

    public static string GetEnvironmentConnectionString(string connectionUrl)
    {
        var dataBaseUri = new Uri(connectionUrl);
        var dbFolder = dataBaseUri.LocalPath.Trim('/');
        var userInfo = dataBaseUri.UserInfo.Split(':', StringSplitOptions.RemoveEmptyEntries);
        return $"Server={dataBaseUri.Host};Port={dataBaseUri.Port};Database={dbFolder};Uid={userInfo[0]};Pwd={userInfo[1]};";
    }

    public static bool IsValidPassword(string passwordValue)
    {
        var regex = new Regex(RegexConstantsCore.RGX_PASSWORD_PATTERN_V2);

        if(!regex.IsMatch(passwordValue))
            return false;

        for(int i = 1; i < passwordValue.Length; i++)
        {
            if(passwordValue[i] == passwordValue[i - 1])
                return false;
        }

        for(int i = 1; i < passwordValue.Length; i++)
        {
            if(char.IsDigit(passwordValue[i]) && char.IsDigit(passwordValue[i - 1]))
            {
                int diff = passwordValue[i] - passwordValue[i - 1];
                if(Math.Abs(diff) == 1)
                    return false;
            }
        }

        return true;
    }

    public static IEnumerable<Type> GetExceptionsFromNamespace(Assembly assemblyObject, string namespaceValue)
    {
        return assemblyObject.GetTypes()
            .Where(type => type.IsClass && !type.IsAbstract && 
                   type.Namespace == namespaceValue && typeof(Exception).IsAssignableFrom(type));
    }

    public static (string HexHash, string Base64Hash) GenerateHash512(string input)
    {
        using(SHA512 sha512 = SHA512.Create())
        {
            byte[] hashBytes = sha512.ComputeHash(Encoding.UTF8.GetBytes(input));
            string hexHash = BitConverter.ToString(hashBytes).Replace("-", string.Empty).ToLower();
            string base64Hash = Convert.ToBase64String(hashBytes);
            return (hexHash, base64Hash);
        }
    }

    public static (string HexHash, string Base64Hash) GenerateHash256(string input)
    {
        using(SHA256 sha256 = SHA256.Create())
        {
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
            string base64Hash = Convert.ToBase64String(hashBytes);
            string hexHash = BitConverter.ToString(hashBytes).Replace("-", string.Empty);
            return (hexHash, base64Hash);
        }
    }

    #region "Private methods."

    private static IEnumerable<T> DataReaderMapToListIteratorAsync<T>(IDataReader drReader)
    {
        while(drReader.Read())
        {
            var item = Activator.CreateInstance<T>();

            foreach(var property in typeof(T).GetProperties().Where(property => property.Name != MainConstantsCore.CFG_DOMAIN_EVENT_LAB))
            {
                if(!drReader.IsDBNull(drReader.GetOrdinal(property.Name)))
                {
                    var propertyValue = drReader[property.Name];
                    var targetType = Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType;

                    if(targetType.IsEnum)
                    {
                        var enumValue = Enum.Parse(targetType, propertyValue.ToString());
                        property.SetValue(item, enumValue, null);
                    }
                    else
                    {
                        property.SetValue(item, Convert.ChangeType(propertyValue, targetType), null);
                    }
                }
            }

            yield return item;
        }
    }

    #endregion
}
