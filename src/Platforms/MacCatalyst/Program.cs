// <copyright file="Program.cs" company="Drastic Actions">
// Copyright (c) Drastic Actions. All rights reserved.
// </copyright>

using System.Reflection;
using ObjCRuntime;
using UIKit;

namespace StableDiffusionMaui;

public class Program
{
    // This is the main entry point of the application.
    private static void Main(string[] args)
    {
        StableDiffusion.NET.StableDiffusionModel.LoadNativeLibrary(Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location)!, "libstable-diffusion.dylib"));
        StableDiffusion.NET.StableDiffusionModel.Log += (s, e) =>
        {
            System.Diagnostics.Debug.WriteLine(e.Text);
        };

        // if you want to use a different Application Delegate class from "AppDelegate"
        // you can specify it here.
        UIApplication.Main(args, null, typeof(AppDelegate));
    }
}
