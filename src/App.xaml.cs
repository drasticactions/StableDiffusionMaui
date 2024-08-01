// <copyright file="App.xaml.cs" company="Drastic Actions">
// Copyright (c) Drastic Actions. All rights reserved.
// </copyright>

namespace StableDiffusionMaui;

public partial class App : Application
{
    private readonly IServiceProvider provider;

    public App(IServiceProvider provider)
    {
        this.InitializeComponent();
        this.provider = provider;
    }

    protected override Window CreateWindow(IActivationState? activationState)
    {
        return new Window(new MainPage());
    }
}
