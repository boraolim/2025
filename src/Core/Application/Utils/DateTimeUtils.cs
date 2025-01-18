using System;
using System.Globalization;

using MainConstantsCore = Core.Domain.Constants.MainConstants ;

namespace Core.Application.Utils;

public static class DateTimeUtils
{
    public static DateTime ObtenerPrimerMinutoDelMes(string mesYAnio) =>
        DateTime.ParseExact(mesYAnio, MainConstantsCore.CFG_DATE_SHORT_MONTH, CultureInfo.InvariantCulture);

    public static DateTime ObtenerUltimoMinutoDelMes(string mesYAnio)
    {
        var fechaInicioMes = DateTime.ParseExact(mesYAnio, MainConstantsCore.CFG_DATE_SHORT_MONTH, CultureInfo.InvariantCulture);
        var ultimoDiaDelMes = fechaInicioMes.AddMonths(1).AddDays(-1);
        return ultimoDiaDelMes.AddHours(23).AddMinutes(59).AddSeconds(59);
    }

    public static DateTime GetDateFromLinuxDateTime(long timeStamp) =>
        DateTimeOffset.FromUnixTimeSeconds(timeStamp).UtcDateTime;
}
