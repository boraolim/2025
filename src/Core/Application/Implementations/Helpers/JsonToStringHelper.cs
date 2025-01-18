using Core.Application.Abstractions.Helpers;

namespace Core.Application.Implementations.Helpers;

public class JsonToStringHelper<T> : IJsonToStringHelper<T>
{
    public string SerializeToString(in T objSource)
    {
        return JsonConvert.SerializeObject(objSource, new JsonSerializerSettings()
        {
            Culture = System.Globalization.CultureInfo.InvariantCulture,
            ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
            NullValueHandling = NullValueHandling.Ignore,
            DateTimeZoneHandling = DateTimeZoneHandling.Utc,
            FloatFormatHandling = FloatFormatHandling.DefaultValue,
            FloatParseHandling = FloatParseHandling.Decimal,
            Formatting = Formatting.Indented,
            ContractResolver = new CamelCasePropertyNamesContractResolver()
        });
    }
}
