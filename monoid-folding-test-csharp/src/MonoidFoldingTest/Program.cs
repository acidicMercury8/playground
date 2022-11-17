using MaxTemperatureMonoidFolding;

var s1 = new Series<(int, int)>(new[] { (1, 100), (2, 300), (3, 120) });
var s2 = new Series<(int, int)>(new[] { (1, 100) });
var s3 = new Series<(int, int)>(Array.Empty<(int, int)>());

var maxT = new MaxTemperature();

Console.WriteLine(s1.Reduce(maxT));
Console.WriteLine(s2.Reduce(maxT));
Console.WriteLine(s3.Reduce(maxT));
Console.WriteLine(maxT.Op(s1.Reduce(maxT), s1.Reduce(maxT)));
