using System;

using Avalonia;

namespace LocalizationApplication;

internal class Program {
    // Avalonia configuration, also used by visual designer
    public static AppBuilder BuildAvaloniaApp() =>
        AppBuilder
            .Configure<App>()
            .UsePlatformDetect()
            .WithInterFont()
            .LogToTrace();

    // Initialization code
    [STAThread]
    public static void Main(string[] args) =>
        BuildAvaloniaApp()
            .StartWithClassicDesktopLifetime(args);
}
