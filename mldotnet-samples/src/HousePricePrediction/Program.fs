open Microsoft.ML
open Microsoft.ML.Data

open HousePricePrediction

[<EntryPoint>]
let main _ =
    // Create context
    let mlContext = new MLContext()

    // Create training data
    let houseData = [|
        {| Size = 1.1f; Price = 1.2f |};
        {| Size = 1.9f; Price = 2.3f |};
        {| Size = 2.8f; Price = 3.0f |};
        {| Size = 3.4f; Price = 3.7f |}
    |]
    let trainingData = mlContext.Data.LoadFromEnumerable(houseData)

    // Specify data preparation and model training pipeline
    let pipeline =
        EstimatorChain()
            .Append(mlContext.Transforms
                .Concatenate("Features", [| "Size" |]))
            .Append(mlContext.Regression.Trainers
                .Sdca(labelColumnName = "Price", maximumNumberOfIterations = 100))

    // Train model
    let model = pipeline.Fit trainingData

    // Make prediction
    let size = { Size = 2.5f; Price = 0.0f }
    let price = mlContext.Model.CreatePredictionEngine<HouseData, HousePrediction>(model).Predict(size)

    // Print result
    printfn $"Predicted price for size: {size.Size * 1000f} sq ft= ${price.Price * 100f:C}k"

    // Save transformer model and training schema
    mlContext.Model.Save(model, trainingData.Schema, "houseSchema.zip")

    0
