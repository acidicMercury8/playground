using Microsoft.ML.Data;

namespace HousePricePrediction;

public class HousePrediction {
    [ColumnName("Score")]
    public float Price { get; set; }
}
