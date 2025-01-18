using RegexConstantsCore = Core.Domain.Constants.RegexConstants;

namespace Core.Utils.Functions;

public static class CoordinateUtils
{
    private static bool IsValidCoordinate(string coord) =>
        double.TryParse(coord, out _);

    public static bool ValidateCoordinatesByRegex(string coordenates) =>
        (!string.IsNullOrEmpty(coordenates) && Regex.IsMatch(coordenates, RegexConstantsCore.RGX_LOCATION_PATTERN));

    public static bool ValidateCoordinates(string coordenates)
    {
        if (!ValidateCoordinatesByRegex(coordenates)) return false;
        string[] arrayCoord = coordenates.Split(",");
        return (arrayCoord.Length == 2 && IsValidCoordinate(arrayCoord[0]) && IsValidCoordinate(arrayCoord[1]));
    }

    public static (double Latitude, double Longitude) GenerateRandomCoordinates()
    {
        Random random = new Random();
        double latitude = random.NextDouble() * 180 - 90;
        double longitude = random.NextDouble() * 360 - 180;
        return (latitude, longitude);
    }

    public static (decimal Latitude, decimal Longitude) GenerateCoordinates(string coordinatesString)
    {
        if (!ValidateCoordinates(coordinatesString)) return (0, 0);
        string[] arrayCoord = coordinatesString.Split(",");
        decimal latitude = Decimal.Parse(arrayCoord[0], NumberStyles.AllowLeadingSign | NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture);
        decimal longitude = Decimal.Parse(arrayCoord[1], NumberStyles.AllowLeadingSign | NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture);
        return (latitude, longitude);
    }

    public static string FormatCoordinatesAsText(double latitude, double longitude) =>
        $"{latitude:0.##############},{longitude:0.##############}";
}
