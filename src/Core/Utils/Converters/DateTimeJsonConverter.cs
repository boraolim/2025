using FormatConstantsCore = Core.Domain.Constants.FormatConstants;

namespace Core.Utils.Converters;

public class DateTimeJsonConverter : JsonConverterNet.JsonConverter<DateTime>
{
    public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) =>
         DateTime.ParseExact(reader.GetString(), FormatConstantsCore.CFG_DATE_ISO_8601, CultureInfo.InvariantCulture);

    public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options) =>
        writer.WriteStringValue(value.ToString(FormatConstantsCore.CFG_DATE_ISO_8601));
}
