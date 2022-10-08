namespace MaxTemperatureMonoidFolding;

public class Series<T> {
    private T[] Values { get; set; }

    public Series(T[] values) {
        Values = values;
    }

    public T Reduce(IMonoid<T> monoid) {
        var result = monoid.Zero();
        for (var i = 0; i < Values.Length; i++)
        {
            result = monoid.Op(result, Values[i]);
        }
        return result;
    }
}
