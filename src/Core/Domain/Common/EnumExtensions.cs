using Core.Domain.Constants;

namespace Core.Domain.Common
{
    public static class EnumExtensions
    {
        public static T GetAttribute<T>(this Enum value) where T : Attribute
        {
            var type = value.GetType();
            var memberInfo = type.GetMember(value.ToString());
            var attributes = memberInfo[MainConstants.CFG_ZERO].GetCustomAttributes(typeof(T), false);
            return attributes.Length > MainConstants.CFG_ZERO ? (T)attributes[0] : null;
        }

        public static string GetDescription(this Enum value)
        {
            var attribute = value.GetAttribute<DescriptionAttribute>();
            return attribute.CheckIsNull() ? value.ToString() : attribute.Description;
        }

        public static Type GetUnderlyingType<T>(this T enumValue) where T : Enum =>
            Enum.GetUnderlyingType(typeof(T));
        public static T Parse<T>(this string value) where T : Enum =>
            (T)Enum.Parse(typeof(T), value);
        public static string GetName<T>(this T enumValue) where T : Enum =>
            Enum.GetName(typeof(T), enumValue);
        public static int CompareTo<T>(this T enumValue, T other) where T : Enum =>
            enumValue.CompareTo(other);
        public static bool Equals<T>(this T enumValue, T other) where T : Enum =>
            enumValue.Equals(other);
        public static int GetHashCode<T>(this T enumValue) where T : Enum =>
            enumValue.GetHashCode();
        public static TypeCode GetTypeCode<T>(this T enumValue) where T : Enum =>
            Convert.GetTypeCode(enumValue);
        public static bool HasFlag<T>(this T enumValue, T flag) where T : Enum =>
            enumValue.HasFlag(flag);
        public static List<T> GetValues<T>() where T : Enum =>
            Enum.GetValues(typeof(T)).Cast<T>().ToList();
        public static bool IsDefined<T>(this T enumValue) where T : Enum =>
            Enum.IsDefined(typeof(T), enumValue);
        public static string ToStringValue<T>(this T enumValue) where T : Enum =>
            enumValue.ToString();
        public static string ToStringLowerValue<T>(this T enumValue) where T : Enum =>
            enumValue.ToString().ToLower();
        public static string ToStringUpperValue<T>(this T enumValue) where T : Enum =>
            enumValue.ToString().ToUpper();
    }
}
