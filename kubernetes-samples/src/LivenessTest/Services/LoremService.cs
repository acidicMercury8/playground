using LoremNET;

namespace LivenessTest.Services;

public class LoremService {
    private readonly int _wordCountMin = 7;
    private readonly int _wordCountMax = 12;

    public string GetSentence() =>
        Lorem.Sentence(_wordCountMin, _wordCountMax);
}
