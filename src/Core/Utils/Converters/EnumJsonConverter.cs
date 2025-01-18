using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Utils.Converters;

public class EnumJsonConverter<T> : System.Text.Json.Serialization.JsonConverter<T> where T : struct, System.Enum
{
    public override T Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        var enumString = reader.GetString();
        if(System.Enum.TryParse(enumString, true, out T value))
            return value;

        throw new System.Text.Json.JsonException(string.Format(MessageConstantsCore.MSG_FAIL_TO_ENUM, enumString, typeof(T).Name.Trim()));
    }

    public override void Write(Utf8JsonWriter writer, T value, JsonSerializerOptions options) =>
        writer.WriteStringValue(value.ToString());
}
