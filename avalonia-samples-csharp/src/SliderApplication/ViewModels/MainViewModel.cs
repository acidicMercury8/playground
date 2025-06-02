using ReactiveUI;

namespace SliderApplication.ViewModels;

public class MainViewModel : ReactiveObject {
    private int _value;

    public int Value {
        get => _value;
        set => this.RaiseAndSetIfChanged(ref _value, value);
    }
}
