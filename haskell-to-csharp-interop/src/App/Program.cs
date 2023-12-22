using System.Runtime.InteropServices;

namespace App;

public class Program {
    private const string _library = "Library.so";

    [DllImport(_library, CallingConvention = CallingConvention.Cdecl, EntryPoint = "hs_init")]
    private static extern void InitializeRuntime(IntPtr argc, IntPtr argv);

    [DllImport(_library, CallingConvention = CallingConvention.Cdecl, EntryPoint = "hs_exit")]
    private static extern void ExitRuntime();

    [DllImport(_library, CallingConvention = CallingConvention.Cdecl, EntryPoint = "printString", CharSet = CharSet.Unicode)]
    private static extern void PrintString(string source);

    public static void Main() {
        Console.WriteLine("Initializing runtime...");
        InitializeRuntime(IntPtr.Zero, IntPtr.Zero);

        try {
            Console.WriteLine("Calling to Haskell...");
            PrintString("C#");
        } finally {
            Console.WriteLine("Exiting runtime...");
            ExitRuntime();
        }
    }
    
}
