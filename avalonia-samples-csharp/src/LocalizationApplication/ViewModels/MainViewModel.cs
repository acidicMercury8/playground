using System.Globalization;
using System.Threading;

using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

using LocalResources = LocalizationApplication.Resources;

namespace LocalizationApplication.ViewModels;

public partial class MainViewModel : ObservableObject {
    [ObservableProperty]
    private string? _text = LocalResources.Greetings;

    [RelayCommand]
    private void ChangeLocale() {
        LocalResources.Culture = new CultureInfo("ru-RU");
        Thread.CurrentThread.CurrentUICulture = new CultureInfo("ru-RU");

        Text = LocalResources.Greetings;
    }
}
