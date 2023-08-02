using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Data.Core.Plugins;
using Avalonia.Markup.Xaml;

using DockingApplication.ViewModels;
using DockingApplication.Views;

namespace DockingApplication;

public partial class App : Application {
    public override void Initialize() {
        AvaloniaXamlLoader.Load(this);
    }

    public override void OnFrameworkInitializationCompleted() {
        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop) {
            BindingPlugins.DataValidators.RemoveAt(0);

            var mainViewModel = new MainViewModel();
            var mainWindow = new MainWindow {
                DataContext = mainViewModel,
            };
            mainWindow.Closing += (_, _) => {
                mainViewModel.CloseLayout();
            };

            desktop.MainWindow = mainWindow;

            desktop.Exit += (_, _) => {
                mainViewModel.CloseLayout();
            };
        }

        base.OnFrameworkInitializationCompleted();
    }
}
