using Microsoft.ML.Data;

namespace HousePricePrediction;

public class Prediction {
    [ColumnName("Score")]
    public float Price { get; set; }
}
