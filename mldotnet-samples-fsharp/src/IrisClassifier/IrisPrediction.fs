namespace IrisClassifier

open Microsoft.ML.Data

[<CLIMutable>]
type IrisPrediction = {
    [<ColumnName("PredictedLabel")>]
    PredictedLabels: string;
}
