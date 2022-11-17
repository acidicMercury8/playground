namespace MaxTemperatureMonoidFolding;

public interface IMonoid<T> {
    T Zero();
    bool IsZero(T v);
    T Op(T a, T b);
}
