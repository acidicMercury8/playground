using System.Collections.ObjectModel;

using Dock.Model.Mvvm.Controls;

namespace DockingApplication.ViewModels.Toolbars;

public class ListViewModel : Tool {
    private ObservableCollection<string> _list = new() {
        "123", "321", "213",
    };

    public ObservableCollection<string> List {
        get => _list;
        set => SetProperty(ref _list, value);
    }
}
