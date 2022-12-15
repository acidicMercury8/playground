// Load sample data
using TaxiFarePrediction;

var sampleData = new Prediction.ModelInput() {
    Vendor_id = @"CMT",
    Rate_code = 1F,
    Passenger_count = 1F,
    Payment_type = @"CRD",
};

// Load model and predict output
var result = Prediction.Predict(sampleData);

Console.WriteLine($"Predicted Fare: {result.Fare_amount}");
