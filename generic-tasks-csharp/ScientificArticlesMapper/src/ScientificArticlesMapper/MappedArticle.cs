namespace ScientificArticlesMapper;

public class MappedArticle {
    public string? Title { get; set; }

    public string? Type { get; set; }

    public string? Publisher { get; set; }

    public string? ContainerTitle { get; set; }

    public List<string>? Subject { get; set; }
}
