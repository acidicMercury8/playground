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
        if (LocalResources.Culture.Name == "en-US") {
            LocalResources.Culture = new CultureInfo("ru-RU");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ru-RU");
        } else {
            LocalResources.Culture = new CultureInfo("en-US");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
        }

        Text = LocalResources.Greetings;
    }
}
