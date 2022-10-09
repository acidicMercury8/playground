using System;
using System.Windows;

using Microsoft.AspNetCore.SignalR.Client;

namespace SimpleChat.Wpf {
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window {
        private HubConnection? _connection;

        public MainWindow() {
            InitializeComponent();
        }

        private async void ConnectButton_ClickAsync(object sender, RoutedEventArgs e) {
            _connection = new HubConnectionBuilder()
               .WithUrl(ServerTextBox.Text)
               .Build();

            _connection.On<string, string>("ReceiveMessage", (user, message) => {
                Dispatcher.Invoke(() => {
                    var newMessage = $"{user}: {message}";
                    MessagesList.Items.Add(newMessage);
                });
            });

            try {
                await _connection.StartAsync();
                MessagesList.Items.Add("Connection started");
                ConnectButton.IsEnabled = false;
                SendButton.IsEnabled = true;
            } catch (Exception ex) {
                MessagesList.Items.Add(ex.Message);
            }
        }

        private async void SendButton_ClickAsync(object sender, RoutedEventArgs e) {
            try {
                await _connection!.InvokeAsync("SendMessage", UserTextBox.Text, MessageTextBox.Text);
            } catch (Exception ex) {
                MessagesList.Items.Add(ex.Message);
            }
        }
    }
}
