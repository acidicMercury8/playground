using System.Globalization;

using CsvHelper;
using CsvHelper.Configuration;

using ScientificArticlesMapper;

var config = new CsvConfiguration(CultureInfo.InvariantCulture) {
    Delimiter= ";",
};

using var reader = new StreamReader(args[0]);
using var csv = new CsvReader(reader, config);
var records = csv.GetRecords<Article>()
    .Select(record => new Article {
        Title = record.Title?.TrimEnd(),
        Type = record.Type?.TrimEnd(),
        Publisher = record.Publisher?.TrimEnd(),
        ContainerTitle = record.ContainerTitle?.TrimEnd(),
        Subject = record.Subject?.TrimEnd(),
    });

var mappedRecords = records
    .Select(record => new MappedArticle {
        Title = record.Title,
        Type = record.Type,
        Publisher = record.Publisher,
        ContainerTitle = record.ContainerTitle,
        Subject = record.Subject
            ?.Split(new char[] { ',' })
            .Select(sub => sub.TrimStart('[').TrimEnd(']'))
            .ToList(),
    });

var printable = mappedRecords.Take(5).ToList();
foreach (var record in printable) {
    Console.Write(record.Title);
    Console.Write("; ");
    Console.Write(record.Type);
    Console.Write("; ");
    Console.Write(record.Publisher);
    Console.Write("; ");
    Console.Write(record.ContainerTitle);
    Console.Write("!!! ");
            
    foreach (var sub in record.Subject!) {
        Console.WriteLine(sub + ",,, ");
    }

    Console.WriteLine(";\n");
}
