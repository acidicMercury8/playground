using System;
using System.Windows.Forms;

namespace ListApp
{
    internal static class Program
    {
        /// <summary>
        /// Main entry point for the application
        /// </summary>
        [STAThread]
        private static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration
#if NET6_0_OR_GREATER
            ApplicationConfiguration.Initialize();
#endif

#if NET5_0 || NETCOREAPP3_1 || NET46_OR_GREATER
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
#endif

            Application.Run(new MainForm());
        }
    }
}
