using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Effects;

namespace WpfApplication;

public class BrightnessAndContrastEffect : ShaderEffect {
    public Brush Input {
        get => (Brush) GetValue(InputProperty);
        set => SetValue(InputProperty, value);
    }

    public double Brightness {
        get => (double) GetValue(BrightnessProperty);
        set => SetValue(BrightnessProperty, value);
    }

    public double Contrast {
        get => (double) GetValue(ContrastProperty);
        set => SetValue(ContrastProperty, value);
    }

    public static readonly DependencyProperty InputProperty =
        RegisterPixelShaderSamplerProperty(nameof(Input),
            typeof(BrightnessAndContrastEffect), 0);

    public static readonly DependencyProperty BrightnessProperty =
        DependencyProperty.Register(nameof(Brightness),
            typeof(double), typeof(BrightnessAndContrastEffect),
            new UIPropertyMetadata(0.0, PixelShaderConstantCallback(0)));

    public static readonly DependencyProperty ContrastProperty =
        DependencyProperty.Register(nameof(Contrast), typeof(double),
            typeof(BrightnessAndContrastEffect),
            new UIPropertyMetadata(0.0, PixelShaderConstantCallback(1)));

    public BrightnessAndContrastEffect() {
        PixelShader = new() {
            UriSource = new Uri(@"pack://application:,,,/WpfApplication;component/BrightnessAndContrast.ps.cso"),
        };

        UpdateShaderValue(InputProperty);
        UpdateShaderValue(BrightnessProperty);
        UpdateShaderValue(ContrastProperty);
    }
}
