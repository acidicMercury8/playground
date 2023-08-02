using Dock.Model.Mvvm.Controls;

namespace DockingApplication.ViewModels.Documents;

public class FileViewModel : Document {
    private string _text = string.Empty;

    public string Text {
        get => _text;
        set => SetProperty(ref _text, value);
    }
}
