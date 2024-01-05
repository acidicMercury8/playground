using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Windows.Interop;

namespace WpfApplication;

public class ControlHost : HwndHost {
    private IntPtr _nativeWindowHandle;

    internal class NativeImports {
        [DllImport("user32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool DestroyWindow(IntPtr hWnd);

        [DllImport("NativeLibrary", EntryPoint = "fnNativeLibrary")]
        public static extern IntPtr InitializeNativeWindow(IntPtr handle);
    }

    public ControlHost() {
        _nativeWindowHandle = IntPtr.Zero;
    }

    protected override HandleRef BuildWindowCore(HandleRef hwndParent) {
        _nativeWindowHandle = NativeImports.InitializeNativeWindow(hwndParent.Handle);
        Debug.Assert(_nativeWindowHandle != IntPtr.Zero);
        return new HandleRef(this, _nativeWindowHandle);
    }

    protected override void DestroyWindowCore(HandleRef hwnd) {
        NativeImports.DestroyWindow(_nativeWindowHandle);
        _nativeWindowHandle = IntPtr.Zero;
    }
}
