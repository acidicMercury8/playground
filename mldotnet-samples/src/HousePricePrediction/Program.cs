using Microsoft.ML;

using HousePricePrediction;

// Create context
var mlContext = new MLContext();

// Create training data
var houseData = new HouseData[] {
    new HouseData() { Size = 1.1F, Price = 1.2F, },
    new HouseData() { Size = 1.9F, Price = 2.3F, },
    new HouseData() { Size = 2.8F, Price = 3.0F, },
    new HouseData() { Size = 3.4F, Price = 3.7F, },
};
var trainingData = mlContext.Data.LoadFromEnumerable(houseData);

// Specify data preparation and model training pipeline
var pipeline = mlContext.Transforms
    .Concatenate("Features", new[] { "Size" })
    .Append(mlContext.Regression.Trainers
        .Sdca(labelColumnName: "Price", maximumNumberOfIterations: 100));

// Train model
var model = pipeline.Fit(trainingData);

// Make prediction
var size = new HouseData() { Size = 2.5F, };
var price = mlContext.Model
    .CreatePredictionEngine<HouseData, Prediction>(model)
    .Predict(size);

// Print result
Console.WriteLine($"Predicted price for size: {size.Size * 1000} sq ft= ${price.Price * 100:C}k");

// Save transformer model and training schema
mlContext.Model.Save(model, trainingData.Schema, "houseData.zip");
