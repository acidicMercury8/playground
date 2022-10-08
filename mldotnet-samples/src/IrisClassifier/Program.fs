open Microsoft.ML
open Microsoft.ML.Data

open IrisClassifier

[<EntryPoint>]
let main _ =
    let mlContext = new MLContext()

    let dataLoader = mlContext.Data.CreateTextLoader<IrisData>(separatorChar = ',', hasHeader = true)
    let trainingData = dataLoader.Load(@"Datas\iris.data")

    let pipeline =
        EstimatorChain()
            .Append(mlContext.Transforms.Conversion
                .MapValueToKey("Label"))
            .Append(mlContext.Transforms
                .Concatenate("Features", "SepalLength", "SepalWidth", "PetalLength", "PetalWidth"))
            .Append(mlContext.MulticlassClassification.Trainers
                .SdcaNonCalibrated(labelColumnName = "Label", featureColumnName = "Features"))
            .Append(mlContext.Transforms.Conversion
                .MapKeyToValue("PredictedLabel"))

    let model = pipeline.Fit trainingData

    let prediction =
        mlContext.Model
            .CreatePredictionEngine<IrisData, IrisPrediction>(model)
            .Predict({
                SepalLength = 3.3f;
                SepalWidth = 1.6f;
                PetalLength = 0.2f;
                PetalWidth = 5.1f;
                Label = ""
            })

    printfn $"Predicted flower type is: {prediction.PredictedLabels}"

    mlContext.Model.Save(model, trainingData.Schema, "irisSchema.zip")

    0
