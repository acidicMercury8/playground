using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

using System.ComponentModel.DataAnnotations;

namespace AvaloniaApplication1.ViewModels;

public partial class MainViewModel : ObservableValidator
{
    public MainViewModel()
    {
        ValidateAllProperties();
    }

    [ObservableProperty]
    [NotifyDataErrorInfo]
    [Required]
    [StringLength(10, MinimumLength = 5)]
    private string? login = string.Empty;

    [ObservableProperty]
    [NotifyDataErrorInfo]
    [Required]
    [Range(0, 200)]
    [CustomValidation(typeof(MainViewModel), nameof(ValidatePassword))]
    private string? password = "10";

    public static ValidationResult ValidatePassword(string password, ValidationContext context)
    {
        if (int.TryParse(password, out int number))
        {
            return new("Validation failed/show error message");
        }
        return ValidationResult.Success!;
    }

    [RelayCommand]
    private void ExecuteLogin()
    {
        ValidateAllProperties();

        if (HasErrors)
        {
            return;
        }
    }
}
