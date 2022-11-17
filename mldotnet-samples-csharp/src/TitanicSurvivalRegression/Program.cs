using System.Globalization;
using System.Text.RegularExpressions;

using TitanicSurvivalRegression;

var testPath = @"Datas\test.csv";
var resultPath = @"Datas\predict.csv";

#region Column indexes
var passengerIdColumn = 0;
var passengerClassColumn = 1;
var genderColumn = 3;
var ageColumn = 4;
var sibSpColumn = 5;
var parchColumn = 6;
var fareColummn = 8;
var embarkedColumn = 10;
#endregion

var thresold = 0.5f;

var csvPattern = new Regex(",(?=(?:[^\"]*\"[^\"]*\")*(?![^\"]*\"))");

using var writer = File.CreateText(resultPath);
writer.WriteLine("PassengerId,Survived");

var testRows = File.ReadAllLines(testPath);
for (var i = 1; i < testRows.Length; i++) {
    var row = csvPattern.Split(testRows[i]);
    var sampleData = new TitanicModel.ModelInput() {
        Pclass = float.Parse(row[passengerClassColumn], CultureInfo.InvariantCulture.NumberFormat),
        Gender = row[genderColumn],
        Age = string.IsNullOrEmpty(row[ageColumn])
            ? 0f
            : float.Parse(row[ageColumn], CultureInfo.InvariantCulture.NumberFormat),
        SibSp = float.Parse(row[sibSpColumn], CultureInfo.InvariantCulture.NumberFormat),
        Parch = float.Parse(row[parchColumn], CultureInfo.InvariantCulture.NumberFormat),
        Fare = string.IsNullOrEmpty(row[fareColummn])
            ? 0f
            : float.Parse(row[fareColummn], CultureInfo.InvariantCulture.NumberFormat),
        Embarked = row[embarkedColumn],
    };
    var result = TitanicModel.Predict(sampleData).Score;

    var toWrite = $"{row[passengerIdColumn]},{(result > thresold ? "1" : "0")}";
    Console.WriteLine(toWrite);
    writer.WriteLine(toWrite);
}

Console.WriteLine("Completed");
