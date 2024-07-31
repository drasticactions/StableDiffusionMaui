// <copyright file="MainPage.xaml.cs" company="Drastic Actions">
// Copyright (c) Drastic Actions. All rights reserved.
// </copyright>

using StableDiffusion.NET;

namespace StableDiffusionMaui;

public partial class MainPage : ContentPage
{
    private int count = 0;

    public MainPage()
    {
        this.InitializeComponent();
    }

    private void OnCounterClicked(object sender, EventArgs e)
    {
        try
        {
            var test = StableDiffusionModel.GetSystemInfo();
            this.count++;

            if (this.count == 1)
            {
                this.CounterBtn.Text = $"Clicked {this.count} time";
            }
            else
            {
                this.CounterBtn.Text = $"Clicked {this.count} times";
            }

            SemanticScreenReader.Announce(this.CounterBtn.Text);
        }
        catch (Exception ex)
        {
        }
    }
}
