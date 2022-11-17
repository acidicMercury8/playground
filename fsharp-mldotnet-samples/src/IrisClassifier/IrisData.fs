namespace IrisClassifier

open Microsoft.ML.Data

type IrisData = {
    [<LoadColumn(0)>]
    SepalLength: float32;
    [<LoadColumn(1)>]
    SepalWidth: float32;
    [<LoadColumn(2)>]
    PetalLength: float32;
    [<LoadColumn(3)>]
    PetalWidth: float32;
    [<LoadColumn(4)>]
    Label: string;
}
