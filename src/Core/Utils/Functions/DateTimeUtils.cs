using MainConstantsCore = Core.Domain.Constants.MainConstants;
using FormatConstantsCore = Core.Domain.Constants.FormatConstants;

namespace Core.Utils.Functions;

public static class DateTimeUtils
{
    public static DateTime ObtenerPrimerMinutoDelMes(string mesYAnio) =>
        DateTime.ParseExact(mesYAnio, FormatConstantsCore.CFG_DATE_SHORT_MONTH, CultureInfo.InvariantCulture);

    public static DateTime ObtenerUltimoMinutoDelMes(string mesYAnio)
    {
        var fechaInicioMes = DateTime.ParseExact(mesYAnio, FormatConstantsCore.CFG_DATE_SHORT_MONTH, CultureInfo.InvariantCulture);
        var ultimoDiaDelMes = fechaInicioMes.AddMonths(MainConstantsCore.CFG_ONE_PLUS)
            .AddDays(MainConstantsCore.CFG_ONE_MINUS);
        return ultimoDiaDelMes.AddHours(MainConstantsCore.CFG_LAST_HOUR_OF_DAY)
                .AddMinutes(MainConstantsCore.CFG_LAST_MINUTE_OR_SECOND)
                .AddSeconds(MainConstantsCore.CFG_LAST_MINUTE_OR_SECOND);
    }

    public static DateTime GetDateFromLinuxDateTime(long timeStamp) =>
        DateTimeOffset.FromUnixTimeSeconds(timeStamp).UtcDateTime;
}
