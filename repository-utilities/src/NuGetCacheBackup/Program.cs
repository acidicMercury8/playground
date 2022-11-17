namespace NuGetCacheBackup;

internal class Program {
    private static void Main(string[] args) {
        if (args.Length == 0) {
            Console.WriteLine("Invalid args!");
            return;
        }

        var sourcePath = args[0];
        if (Directory.Exists(sourcePath)) {
            Console.WriteLine("Source path exists!");
        } else {
            Console.WriteLine("Source path does not exist!");
            return;
        }

        var destinationPath = args[1];
        if (Directory.Exists(destinationPath)) {
            Console.WriteLine("Destination path exists!");
        } else {
            Console.WriteLine("Destination path does not exist!");
            Directory.CreateDirectory(destinationPath);
        }

        Console.WriteLine("\nChecking for non-copied packages...\n");

        var sourceDirectories = Directory.GetDirectories(sourcePath);
        var destinationDirectories = Directory.GetDirectories(destinationPath);

        foreach (var directory in sourceDirectories) {
            var directoryName = new DirectoryInfo(directory).Name;
            if (!destinationDirectories.Contains(directory)) {
                Directory.CreateDirectory(destinationPath + "\\" + directoryName);
            }

            var sourcePackagePaths = new List<string>();
            foreach (var subDirectory in Directory.GetDirectories(directory)) {
                var files = Directory.GetFiles(subDirectory, "*.nupkg");
                if (files.Length != 0) {
                    sourcePackagePaths.Add(files[0]);
                }
            }

            var sourcePackageNames = sourcePackagePaths
                .Select(path => Path.GetFileName(path))
                .ToList();
            var sourcePackages = new Dictionary<string, string>();
            sourcePackages = sourcePackageNames
                .Zip(sourcePackagePaths, (s, i) => new { s, i })
                .ToDictionary(item => item.s, item => item.i);

            foreach (var subDirectory in destinationDirectories) {
                if (directoryName == new DirectoryInfo(subDirectory).Name) {
                    foreach (var file in sourcePackages!) {
                        if (!File.Exists(subDirectory + "\\" + file.Key)) {
                            File.Copy(file.Value, subDirectory + "\\" + file.Key);
                            Console.WriteLine($"{file.Key}");
                        }
                    }
                }
            }
        }

        Console.WriteLine("\nAll actions completed!");
        Console.WriteLine("\nPress any key to continue . . .");
        Console.ReadKey(true);
    }
}
