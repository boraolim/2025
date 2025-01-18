namespace Core.Infrastructure.Attributes
{
    public class CustomMigrationAttribute : FluentMigrator.MigrationAttribute
    {
        public CustomMigrationAttribute(int Year, int Month, int Day, int Hour, int Minute, int Seconds,
            FluentMigrator.TransactionBehavior transactionBehavior = FluentMigrator.TransactionBehavior.Default) 
            : base(CalculateValue(Year, Month, Day, Hour, Minute, Seconds), transactionBehavior) { }

        private static long CalculateValue(int Year, int Month, int Day, int Hour, int Minute, int Seconds) =>
            new DateTimeOffset(new DateTime(Year, Month, Day, Hour, Minute, Seconds, DateTimeKind.Utc)).ToUnixTimeSeconds() / 1000;
    }
}
