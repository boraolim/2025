using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Utils.Converters;

public class UuidV4JsonConverter : JsonConverterNet.JsonConverter<Guid>
{
    private static readonly Regex UuidV4Regex = new Regex(RegexConstantsCore.RGX_UUID_V4_PATTERN, RegexOptions.IgnoreCase | RegexOptions.Compiled);

    public override Guid Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        var value = reader.GetString();
        if(string.IsNullOrEmpty(value) || !UuidV4Regex.IsMatch(value))
            throw new System.Text.Json.JsonException(string.Format(MessageConstantsCore.MSG_FAIL_TO_UUID_V4, value));

        return Guid.Parse(value);
    }

    public override void Write(Utf8JsonWriter writer, Guid value, JsonSerializerOptions options) =>
        writer.WriteStringValue(value.ToString());
}
