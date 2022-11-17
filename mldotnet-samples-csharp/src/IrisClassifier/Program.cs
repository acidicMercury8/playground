using Microsoft.ML;

using IrisClassifier;

var mlContext = new MLContext();

var dataLoader = mlContext.Data.CreateTextLoader<IrisData>(separatorChar: ',', hasHeader: true);
var trainingData = dataLoader.Load(@"Datas\iris.data");

var pipeline = mlContext.Transforms.Conversion.MapValueToKey("Label")
    .Append(mlContext.Transforms
        .Concatenate("Features", "SepalLength", "SepalWidth", "PetalLength", "PetalWidth"))
    .Append(mlContext.MulticlassClassification.Trainers
        .SdcaNonCalibrated(labelColumnName: "Label", featureColumnName: "Features"))
    .Append(mlContext.Transforms.Conversion
        .MapKeyToValue("PredictedLabel"));

var model = pipeline.Fit(trainingData);

var prediction = mlContext.Model
    .CreatePredictionEngine<IrisData, IrisPrediction>(model)
    .Predict(new IrisData() {
        SepalLength = 3.3f,
        SepalWidth = 1.6f,
        PetalLength = 0.2f,
        PetalWidth = 5.1f,
    });

Console.WriteLine($"Predicted flower type is: {prediction.PredictedLabels}");

mlContext.Model.Save(model, trainingData.Schema, "irisSchema.zip");
