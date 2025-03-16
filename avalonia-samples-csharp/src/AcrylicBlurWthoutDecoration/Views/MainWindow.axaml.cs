using Avalonia;
using Avalonia.Controls;
using Avalonia.Input;

namespace AcrylicBlurWthoutDecoration.Views;

public partial class MainWindow : Window {
    private bool _isDragging;
    private readonly Point _startPosition;
    private readonly PixelPoint _windowStartPosition;

    public MainWindow() => InitializeComponent();

    private void Window_PointerPressed(object sender, PointerPressedEventArgs e) {
        if (e.GetCurrentPoint(this).Properties.IsLeftButtonPressed) {
            BeginMoveDrag(e);
        }
    }

    private void Window_PointerMoved(object sender, PointerEventArgs e) {
        if (_isDragging) {
            var currentPosition = e.GetPosition(this);
            var offset = currentPosition - _startPosition;
            Position = new PixelPoint(
                _windowStartPosition.X + (int) offset.X,
                _windowStartPosition.Y + (int) offset.Y
            );
        }
    }

    private void Window_PointerReleased(object sender, PointerReleasedEventArgs e) {
        if (_isDragging) {
            _isDragging = false;
            e.Pointer.Capture(null);
        }
    }
}
