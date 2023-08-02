using CommunityToolkit.Mvvm.ComponentModel;

using Dock.Model.Controls;
using Dock.Model.Core;

namespace DockingApplication.ViewModels;

public class MainViewModel : ObservableObject {
    private readonly IFactory? _factory;
    private IRootDock? _layout;

    public IRootDock? Layout {
        get => _layout;
        set => SetProperty(ref _layout, value);
    }

    public MainViewModel() {
        _factory = new AppFactory();

        Layout = _factory?.CreateLayout();
        if (Layout is { }) {
            _factory?.InitLayout(Layout);
        }
    }

    public void CloseLayout() {
        if (Layout is IDock dock) {
            if (dock.Close.CanExecute(null)) {
                dock.Close.Execute(null);
            }
        }
    }
}
