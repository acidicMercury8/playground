using System.Diagnostics;

namespace GitBatchUpdate;

internal class Program {
    private static void Main(string[] args) {
        if (args.Length == 0) {
            Console.WriteLine("Invalid args!");
            return;
        }

        var sourcePath = args[0];
        Console.WriteLine(sourcePath);

        if (Directory.Exists(sourcePath)) {
            Console.WriteLine("Source path exists!");
        } else {
            Console.WriteLine("Source path does not exist!");
        }

        Console.WriteLine();

        var sourceDirectories = Directory.GetDirectories(sourcePath);
        foreach (var directory in sourceDirectories) {
            var process = new Process {
                StartInfo = new ProcessStartInfo {
                    FileName = "git.exe",
                    Arguments = "fetch -v --progress --prune --tags \"origin\"",
                    WorkingDirectory = directory,
                },
            };
            process.Start();
            process.WaitForExit();
            Console.WriteLine();
        }

        Console.WriteLine("All actions completed!\n");
        Console.WriteLine("Press any key to continue...");
        Console.ReadKey(true);
    }
}
