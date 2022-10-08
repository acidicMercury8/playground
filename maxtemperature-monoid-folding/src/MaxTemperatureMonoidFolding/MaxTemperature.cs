namespace MaxTemperatureMonoidFolding;

public class MaxTemperature : IMonoid<(int, int)> {
    public (int, int) Zero() {
        return (0, 0);
    }

    public bool IsZero((int, int) v) {
        (int time, int value) = v;
        return time.Equals(0) && value.Equals(0);
    }

    public (int, int) Op((int, int) a, (int, int) b) {
        if (IsZero(a)) {
            return b;
        }
        if (IsZero(b)) {
            return a;
        }

        (var _, var aValue) = a;
        (var _, var bValue) = b;
        return aValue > bValue
            ? a
            : b;
    }
}
