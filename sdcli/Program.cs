// See https://aka.ms/new-console-template for more information
using System.Runtime.InteropServices;
using StableDiffusion.NET;

LoadNativeLibrary();
StableDiffusionModel.Log += (s, e) =>
{
    Console.WriteLine(e.Text);
};

StableDiffusionModel.Progress += (s, e) =>
{
    Console.WriteLine($"Progress: {e.Step}/{e.Steps} - {e.Time}");
};

var app = ConsoleAppFramework.ConsoleApp.Create();
app.Add<sdcli.Commands>();
app.Run(args);

static void LoadNativeLibrary()
{
    var result = false;
    if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
    {
        result = StableDiffusionModel.LoadNativeLibrary("libstable-diffusion.dylib");
    }

    if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
    {
        result = StableDiffusionModel.LoadNativeLibrary("libstable-diffusion.so");
    }

    if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
    {
        result = StableDiffusionModel.LoadNativeLibrary("stable-diffusion.dll");
    }

    if (!result)
    {
        Console.WriteLine("Failed to load native library.");
    }
}