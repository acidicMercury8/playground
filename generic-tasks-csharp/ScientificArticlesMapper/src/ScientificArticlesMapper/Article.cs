using CsvHelper.Configuration.Attributes;

namespace ScientificArticlesMapper;

public class Article {
    [Name("title")]
    public string? Title { get; set; }

    [Name("type")]
    public string? Type { get; set; }

    [Name("publisher")]
    public string? Publisher { get; set; }

    [Name("container-title")]
    public string? ContainerTitle { get; set; }

    [Name("subject")]
    public string? Subject { get; set; }
}
