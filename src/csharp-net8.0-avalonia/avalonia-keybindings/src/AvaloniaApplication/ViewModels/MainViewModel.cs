using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

namespace AvaloniaApplication.ViewModels;

public partial class MainViewModel : ObservableObject
{
    [ObservableProperty]
    private string _greeting = "Welcome to Avalonia!";

    [ObservableProperty]
    private string _inputText = "";

    [RelayCommand]
    private void AltD(string input)
    {
        Greeting = input;
    }
}
