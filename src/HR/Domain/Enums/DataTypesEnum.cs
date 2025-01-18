using System.ComponentModel;

namespace Hogar.HR.Domain.Enums
{
    public enum DataTypesEnum
    {
        [Description("bool")] BOOL,
        [Description("int")] INT,
        [Description("string")] STRING,
        [Description("double")] DOUBLE,
        [Description("decimal")] DECIMAL,
        [Description("guuid")] GUUID
    }
}
