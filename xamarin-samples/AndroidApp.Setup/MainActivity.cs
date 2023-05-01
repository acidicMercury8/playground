using Android.Content.PM;
using Android.Util;

using AndroidX.AppCompat.App;

using Xamarin.Essentials;

namespace AndroidApp.Setup;

[Activity(Label = "@string/app_name", MainLauncher = true, Theme = "@style/Theme.Material3.DayNight.NoActionBar")]
public class MainActivity : AppCompatActivity
{
    private const string TAG = nameof(MainActivity);

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);

        Platform.Init(this, savedInstanceState);

        // Set our view from the "main" layout resource
        SetContentView(Resource.Layout.activity_main);

        Log.WriteLine(LogPriority.Info, TAG, "Test log");
    }

    public override void OnRequestPermissionsResult(int requestCode, string[] permissions, Permission[] grantResults)
    {
        Platform.OnRequestPermissionsResult(requestCode, permissions, grantResults);

        base.OnRequestPermissionsResult(requestCode, permissions, grantResults);
    }
}
