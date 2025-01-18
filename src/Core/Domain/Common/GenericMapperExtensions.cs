using System;
using System.Linq;
using System.Reflection;
using System.Collections;
using System.Linq.Expressions;
using System.Collections.Generic;

namespace Core.Domain.Common;

public static class GenericMapperExtensions
{
    private static readonly object _lock = new();
    private static readonly Dictionary<(Type, Type), Delegate> _cache = new();

    public static TTarget MapTo<TTarget>(this object source) where TTarget : class
    {
        if(source.CheckIsNull())
            throw new ArgumentNullException(nameof(source));

        var key = (source.GetType(), typeof(TTarget));

        if(!_cache.TryGetValue(key, out var cachedMapper))
        {
            lock(_lock)
            {
                if(!_cache.TryGetValue(key, out cachedMapper))
                {
                    cachedMapper = CreateMapper<TTarget>(source.GetType());
                    _cache[key] = cachedMapper;
                }
            }
        }
        return ((Func<object, TTarget>)cachedMapper)(source);
    }

    #region "Métodos privados"

    private static Func<object, TTarget> CreateMapper<TTarget>(Type sourceType) where TTarget : class
    {
        var sourceParam = Expression.Parameter(typeof(object), "source");
        var sourceTyped = Expression.Convert(sourceParam, sourceType);
        var newInstance = CreateConstructorExpression<TTarget>(sourceType, sourceTyped);
        var bindings = CreateMemberBindings<TTarget>(sourceType, sourceTyped);
        var body = Expression.MemberInit(newInstance, bindings);
        return Expression.Lambda<Func<object, TTarget>>(body, sourceParam).Compile();
    }

    private static NewExpression CreateConstructorExpression<TTarget>(Type sourceType, Expression sourceTyped)
    {
        var constructor = typeof(TTarget).GetConstructors()
            .OrderByDescending(c => c.GetParameters().Length)
            .SingleOrDefault() ??
                throw new InvalidOperationException($"La clase {typeof(TTarget).Name} no tiene un constructor público único.");

        var arguments = constructor.GetParameters()
            .Select(param => GetSourceMemberExpression(sourceType, sourceTyped, param.Name, param.ParameterType) ??
                Expression.Default(param.ParameterType))
            .ToList();
        return Expression.New(constructor, arguments);
    }

    private static List<MemberBinding> CreateMemberBindings<TTarget>(Type sourceType, Expression sourceTyped)
    {
        var bindings = new List<MemberBinding>();

        foreach(var targetMember in typeof(TTarget).GetMembers(BindingFlags.Public | BindingFlags.Instance))
        {
            if((targetMember is PropertyInfo param && param.CanWrite) || targetMember is FieldInfo)
            {
                var sourceValue = GetSourceMemberExpression(sourceType, sourceTyped, targetMember.Name, GetMemberType(targetMember));

                if(!sourceValue.CheckIsNull())
                    bindings.Add(Expression.Bind(targetMember, sourceValue));
            }
        }
        return bindings;
    }

    private static Expression GetSourceMemberExpression(Type sourceType, Expression sourceTyped, string memberName, Type targetType)
    {
        var sourceMember = sourceType.GetMember(memberName, BindingFlags.Public | BindingFlags.Instance)
            .FirstOrDefault(m => (m is PropertyInfo p && p.CanRead) || m is FieldInfo);

        if(sourceMember.CheckIsNull()) return default;

        Expression sourceValue = sourceMember switch
        {
            PropertyInfo prop => Expression.Property(sourceTyped, prop),
            FieldInfo field => Expression.Field(sourceTyped, field),
            _ => null
        };

        return sourceValue != null && sourceValue.Type != targetType ? ConvertExpression(sourceValue, targetType) : sourceValue;
    }

    private static Expression ConvertExpression(Expression source, Type targetType)
    {
        if(targetType.IsAssignableFrom(source.Type)) return source;

        if(typeof(IEnumerable).IsAssignableFrom(targetType) && targetType.IsGenericType)
        {
            Type sourceItemType = source.Type.GetGenericArguments()[0];
            Type targetItemType = targetType.GetGenericArguments()[0];
            return typeof(IDictionary).IsAssignableFrom(targetType)
                ? ConvertDictionary(source, sourceItemType, targetItemType)
                : ConvertCollection(source, sourceItemType, targetItemType);
        }

        return Expression.Convert(source, targetType);
    }
    private static Expression ConvertCollection(Expression source, Type sourceItemType, Type targetItemType)
    {
        if(targetItemType.IsAssignableFrom(sourceItemType)) return source;

        var selectMethod = GetGenericMethod(typeof(Enumerable), "Select", 2, sourceItemType, targetItemType);
        var toListMethod = GetGenericMethod(typeof(Enumerable), "ToList", 1, targetItemType);
        var param = Expression.Parameter(sourceItemType, "x");
        var itemConversion = ConvertExpression(param, targetItemType);
        var selectExpr = Expression.Call(selectMethod, source, Expression.Lambda(itemConversion, param));

        return Expression.Call(toListMethod, selectExpr);
    }
    private static Expression ConvertDictionary(Expression source, Type sourceItemType, Type targetItemType)
    {
        var sourceKeyType = sourceItemType.GetGenericArguments()[0];
        var sourceValueType = sourceItemType.GetGenericArguments()[1];
        var targetKeyType = targetItemType.GetGenericArguments()[0];
        var targetValueType = targetItemType.GetGenericArguments()[1];

        var selectMethod = GetGenericMethod(typeof(Enumerable), "Select", 2,
            typeof(KeyValuePair<,>).MakeGenericType(sourceKeyType, sourceValueType),
            typeof(KeyValuePair<,>).MakeGenericType(targetKeyType, targetValueType));

        var toDictionaryMethod = GetGenericMethod(typeof(Enumerable), "ToDictionary", 3, targetKeyType, targetValueType);

        var param = Expression.Parameter(typeof(KeyValuePair<,>).MakeGenericType(sourceKeyType, sourceValueType), "kv");
        var keyConversion = ConvertExpression(Expression.Property(param, "Key"), targetKeyType);
        var valueConversion = ConvertExpression(Expression.Property(param, "Value"), targetValueType);

        var selectExpr = Expression.Call(selectMethod, source, Expression.Lambda(
            Expression.New(typeof(KeyValuePair<,>).MakeGenericType(targetKeyType, targetValueType)
                .GetConstructor(new[] { targetKeyType, targetValueType }), keyConversion, valueConversion), param));

        return Expression.Call(toDictionaryMethod, selectExpr, Expression.Lambda(Expression.Property(param, "Key"), param),
            Expression.Lambda(Expression.Property(param, "Value"), param));
    }

    private static MethodInfo GetGenericMethod(Type type, string methodName, int genericArgCount, params Type[] typeArgs) =>
        type.GetMethods()
            .First(m => m.Name == methodName && m.GetGenericArguments().Length == genericArgCount)
            .MakeGenericMethod(typeArgs);

    private static Type GetMemberType(MemberInfo member) =>
        member switch
        {
            PropertyInfo prop => prop.PropertyType,
            FieldInfo field => field.FieldType,
            _ => throw new InvalidOperationException()
        };

    #endregion
}
