using System.Windows;

namespace SimpleChat.Wpf {
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application {
        protected override void OnStartup(StartupEventArgs e) {
            base.OnStartup(e);

            var mainWindow = new MainWindow();
            mainWindow.Show();
        }
    }
}
