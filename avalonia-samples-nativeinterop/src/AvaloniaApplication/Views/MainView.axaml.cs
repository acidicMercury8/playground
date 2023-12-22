using Avalonia.Controls;

using AvaloniaApplication.ViewModels;

namespace AvaloniaApplication.Views;

public partial class MainView : UserControl {
    public MainView() {
        InitializeComponent();

        contentControl.Content = new NativeControl();
    }
}
