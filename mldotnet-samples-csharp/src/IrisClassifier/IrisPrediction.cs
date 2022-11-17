using Microsoft.ML.Data;

namespace IrisClassifier;

public class IrisPrediction {
    [ColumnName("PredictedLabel")]
    public string? PredictedLabels = null!;
}
