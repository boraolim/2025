using Core.Domain.Common;
using Core.Domain.Constants;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Utils.Functions;

public static class Functions
{
    private static readonly ConcurrentDictionary<string, Regex> _regexCache = new();

    public static string GenerateRandomString(int sizeLength)
    {
        const string allowedChars = MainConstantsCore.CFG_ALPHA_COLLECTION;
        var result = new StringBuilder();

        var random = new Random();
        for(var i = MainConstantsCore.CFG_ZERO; i < sizeLength; i++)
        {
            var index = random.Next(allowedChars.Length);
            result.Append(allowedChars[index]);
        }

        return result.ToString();
    }

    public static IEnumerable<R> DataReaderMapToListAsync<R>(IDataReader drReader)
    {
        if(drReader.CheckIsNull())
            throw new ArgumentNullException(nameof(drReader));

        return DataReaderMapToListIteratorAsync<R>(drReader).ToList();
    }

    public static IEnumerable<R> PaginateData<R>(this List<R> dataSet, int pageNumber, int pageSize) =>
        dataSet.Skip((pageNumber - MainConstantsCore.CFG_ONE_PLUS) * pageSize).Take(pageSize).ToList();

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
        if(inputHex.Length % 2 != MainConstantsCore.CFG_ZERO)
            throw new ArgumentException(MessageConstantsCore.MSG_PAIR_EXACTLY);

        var bytesHex = new byte[inputHex.Length / 2];

        for(int i = MainConstantsCore.CFG_ZERO; i < bytesHex.Length; i++)
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

        for(int i = MainConstantsCore.CFG_ONE_PLUS; i < passwordValue.Length; i++)
        {
            if(passwordValue[i] == passwordValue[i - MainConstantsCore.CFG_ONE_PLUS])
                return false;
        }

        for(int i = MainConstantsCore.CFG_ONE_PLUS; i < passwordValue.Length; i++)
        {
            if(char.IsDigit(passwordValue[i]) && char.IsDigit(passwordValue[i - MainConstantsCore.CFG_ONE_PLUS]))
            {
                int diff = passwordValue[i] - passwordValue[i - MainConstantsCore.CFG_ONE_PLUS];
                if(Math.Abs(diff) == MainConstantsCore.CFG_ONE_PLUS)
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

    public static bool IsMatch(string inputValue, string patternRegex, double retryInMiliseconds = MainConstantsCore.CFG_ZERO)
    {
        if(string.IsNullOrEmpty(inputValue) || string.IsNullOrEmpty(patternRegex))
            return false;

        var regex = _regexCache.GetOrAdd(patternRegex,
            pattern => new Regex(pattern, RegexOptions.Compiled | RegexOptions.CultureInvariant | RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(retryInMiliseconds)));
        return regex.IsMatch(inputValue);
    }

    public static T? GetEnumValueFromDescription<T>(string description) where T : struct, System.Enum
    {
        foreach(var field in typeof(T).GetFields())
        {
            var attribute = field.GetCustomAttribute<DescriptionAttribute>();
            if(!attribute.CheckIsNull() && attribute.Description.Equals(description, StringComparison.OrdinalIgnoreCase))
                return (T?)field.GetValue(null);
        }
        return null;
    }

    public static string FormatearJson(string input)
    {
        try
        {
            using JsonDocument doc = JsonDocument.Parse(input);
            return FormatearObjectToJson(doc.RootElement);
        }
        catch(JsonException)
        {
            return FormatearObjectToJson(input);
        }
    }

    public static string FormatearObjectToJson(object Input)
    {
        return JsonSerializer.Serialize(Input,
            new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true,
                Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping,
                DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
            });
    }

    public static T FormatearJsonStringToObject<T>(object InputObject) =>
        JsonSerializer.Deserialize<T>(Functions.FormatearObjectToJson(InputObject));

    public static string FormatTextException(Exception exception) =>
        (exception.InnerException.CheckIsNull()) ? LimpiarTexto(exception.Message) : string.Format(FormatConstants.CFG_SEPATOR_ERROR,
            LimpiarTexto(exception.Message), LimpiarTexto(exception.InnerException.Message));

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
                        var method = typeof(Functions).GetMethod(nameof(GetEnumValueFromDescription))
                                                          .MakeGenericMethod(targetType);
                        var hasDescription = method.Invoke(null, new object[] { propertyValue.ToString() });

                        property.SetValue(item, (!hasDescription.CheckIsNull() ? hasDescription :
                            Enum.Parse(targetType, propertyValue.ToString())), null);

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

    private static string LimpiarTexto(string contentText)
    {
        if(string.IsNullOrWhiteSpace(contentText)) return string.Empty;
        return Regex.Replace(contentText, RegexConstants.RGX_SPACE_CLEAR, FormatConstants.CFG_SPACE_BLANK).Trim();
    }


    #endregion
}
