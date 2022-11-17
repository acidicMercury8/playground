namespace HousePricePrediction

open Microsoft.ML.Data

[<CLIMutable>]
type HousePrediction = {
    [<ColumnName("Score")>]
    Price: float32
}
