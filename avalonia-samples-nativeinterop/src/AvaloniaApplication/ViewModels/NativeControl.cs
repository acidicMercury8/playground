using System;
using System.Runtime.InteropServices;

using Avalonia.Controls;
using Avalonia.Platform;

namespace AvaloniaApplication.ViewModels;

public class NativeControl : NativeControlHost {
    internal class NativeImports {
        [DllImport("NativeLibrary", EntryPoint = "fnNativeLibrary")]
        public static extern IntPtr InitializeNativeWindow();
    }

    protected override IPlatformHandle CreateNativeControlCore(IPlatformHandle parent) {
        if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows)) {
            IntPtr nativeWindowHandle = NativeImports.InitializeNativeWindow();
            return new PlatformHandle(nativeWindowHandle, "WND");
        }

        return base.CreateNativeControlCore(parent);
    }

    protected override void DestroyNativeControlCore(IPlatformHandle control) {
        if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows)) {
        }

        base.DestroyNativeControlCore(control);
    }
}
