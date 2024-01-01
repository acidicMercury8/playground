using System;
using System.IO;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;

namespace NuGetDownloader;

internal record class PackageVersions(
    string[] Versions);

internal class Program {
    public static async Task Main(string[] args) {
        string packageId = args[0];

        //ILogger logger = NullLogger.Instance;
        //CancellationToken cancellationToken = CancellationToken.None;

        //SourceCacheContext cache = new();
        //SourceRepository repository = Repository.Factory.GetCoreV3("https://api.nuget.org/v3/index.json");
        //FindPackageByIdResource packageResource = await repository.GetResourceAsync<FindPackageByIdResource>();

        //IEnumerable<NuGetVersion> versions = await packageResource.GetAllVersionsAsync(packageId,
        //    cache, logger, cancellationToken);
        //Console.WriteLine($"Versions:");
        //foreach (NuGetVersion version in versions) {
        //    Console.WriteLine($"{version}");
        //}

        //Console.WriteLine();

        //string currentDirectory = AppDomain.CurrentDomain.BaseDirectory;

        //Console.WriteLine("Downloaded:");
        //foreach (NuGetVersion version in versions) {
        //    using MemoryStream packageStream = new();
        //    await packageResource.CopyNupkgToStreamAsync(packageId, version, packageStream,
        //        cache, logger, cancellationToken);
        //    Console.WriteLine($"{packageId} {version}");

        //    string packageFolderPath = Path.Combine(currentDirectory, "pkg", packageId);
        //    if (!Directory.Exists(packageFolderPath)) {
        //        Directory.CreateDirectory(packageFolderPath.ToLower());
        //    }

        //    string packageFilePath = Path.Combine(packageFolderPath,
        //        packageId.ToLower() + "." + version.ToString().ToLower() + ".nupkg");

        //    packageStream.Seek(0, SeekOrigin.Begin);
        //    using FileStream fileStream = new(packageFilePath, FileMode.Create, FileAccess.Write);
        //    packageStream.CopyTo(fileStream);
        //}

        HttpClient nugetV3Client = new() {
            BaseAddress = new Uri("https://api.nuget.org/v3-flatcontainer"),
        };
        HttpClient nugetV2Client = new() {
            BaseAddress = new Uri("https://www.nuget.org/api/v2"),
        };

        Console.WriteLine($"{packageId.ToLower()}:");

        string packageVersionsRequestUri = nugetV3Client.BaseAddress.ToString() + $"/{packageId.ToLower()}/index.json";
        PackageVersions? packageVersions = await nugetV3Client.GetFromJsonAsync<PackageVersions?>(packageVersionsRequestUri);

        string currentDirectory = AppDomain.CurrentDomain.BaseDirectory;
        string packageFolderPath = Path.Combine(currentDirectory, "pkg", packageId.ToLower());
        if (!Directory.Exists(packageFolderPath)) {
            Directory.CreateDirectory(packageFolderPath.ToLower());
        }

        if (packageVersions is not null) {
            foreach (string packageVersion in packageVersions.Versions) {
                using Stream packageStream = await nugetV2Client.GetStreamAsync(nugetV2Client.BaseAddress.ToString() + $"/package/{packageId.ToLower()}/{packageVersion.ToLower()}");
                using FileStream packageFileStream = new(Path.Combine($"{packageFolderPath}", $"{packageId.ToLower()}.{packageVersion.ToLower()}.nupkg"), FileMode.Create, FileAccess.Write);
                await packageStream.CopyToAsync(packageFileStream);
                Console.WriteLine($"{packageId.ToLower()}.{packageVersion.ToLower()}.nupkg");

                using HttpResponseMessage symbolPackageResponce = await nugetV2Client.GetAsync(nugetV2Client.BaseAddress.ToString() + $"/symbolpackage/{packageId.ToLower()}/{packageVersion.ToLower()}");
                if (symbolPackageResponce.IsSuccessStatusCode) {
                    using Stream symbolPackageStream = await nugetV2Client.GetStreamAsync(nugetV2Client.BaseAddress.ToString() + $"/symbolpackage/{packageId.ToLower()}/{packageVersion.ToLower()}");
                    using FileStream symbolPackageFileStream = new(Path.Combine($"{packageFolderPath}", $"{packageId.ToLower()}.{packageVersion.ToLower()}.snupkg"), FileMode.Create, FileAccess.Write);
                    await symbolPackageStream.CopyToAsync(symbolPackageFileStream);
                    Console.WriteLine($"{packageId.ToLower()}.{packageVersion.ToLower()}.snupkg");
                }
            }
        }
    }
}
