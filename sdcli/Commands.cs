// <copyright file="Commands.cs" company="Drastic Actions">
// Copyright (c) Drastic Actions. All rights reserved.
// </copyright>

using ConsoleAppFramework;
using HPPH.SkiaSharp;
using SkiaSharp;
using StableDiffusion.NET;
namespace sdcli;

internal class Commands
{
    [Command("img2img")]
    public void Img2Img(string modelPath, string prompt, string? vaePath = default, int steps = 25)
    {
        var testModel = new StableDiffusion.NET.StableDiffusionModel(modelPath, new ModelParameter()
        { 
            ThreadCount = 8,
            VaePath = vaePath ?? string.Empty
        });
        var result = testModel.TextToImage(prompt, new StableDiffusionParameter() { SampleSteps = steps });
        using var image = result.ToSKImage();
        using (var data = image.Encode(SKEncodedImageFormat.Png, 100))
        using (var stream = File.OpenWrite("output.png"))
        {
            data.SaveTo(stream);
        }
    }
}