using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

using Avalonia.Controls;
using Avalonia.Platform;

namespace AvaloniaApplication.ViewModels;

public class NativeControl : NativeControlHost {
    private IntPtr _nativeWindowHandle;

    internal class NativeImports {
        [DllImport("user32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool DestroyWindow(IntPtr hWnd);

        [DllImport("NativeLibrary", EntryPoint = "fnNativeLibrary")]
        public static extern IntPtr InitializeNativeWindow();
    }

    public NativeControl() {
        _nativeWindowHandle = IntPtr.Zero;
    }

    protected override IPlatformHandle CreateNativeControlCore(IPlatformHandle parent) {
        if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows)) {
            _nativeWindowHandle = NativeImports.InitializeNativeWindow();
            Debug.Assert(_nativeWindowHandle != IntPtr.Zero);
            return new PlatformHandle(_nativeWindowHandle, "WND");
        }

        return base.CreateNativeControlCore(parent);
    }

    protected override void DestroyNativeControlCore(IPlatformHandle control) {
        if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows)) {
            NativeImports.DestroyWindow(_nativeWindowHandle);
            _nativeWindowHandle = IntPtr.Zero;
        }

        base.DestroyNativeControlCore(control);
    }
}
