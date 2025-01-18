using System;
using System.Text.Json;
using System.Globalization;
using System.Text.Json.Serialization;

using MainConstantsCore = Core.Domain.Constants.MainConstants;

namespace Core.Application.Utils;

public class DateTimeJsonConverter : JsonConverter<DateTime>
{
    public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) =>
         DateTime.ParseExact(reader.GetString(), MainConstantsCore.CFG_DATE_ISO_8601, CultureInfo.InvariantCulture);

    public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options) =>
        writer.WriteStringValue(value.ToString(MainConstantsCore.CFG_DATE_ISO_8601));
}
