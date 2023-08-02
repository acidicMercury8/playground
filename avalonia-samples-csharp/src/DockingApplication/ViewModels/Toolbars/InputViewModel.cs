using Dock.Model.Mvvm.Controls;

namespace DockingApplication.ViewModels.Toolbars;

public class InputViewModel : Tool {
    private string _text = string.Empty;

    public string Text {
        get => _text;
        set => SetProperty(ref _text, value);
    }
}
