// <copyright file="PromptViewModel.cs" company="Drastic Actions">
// Copyright (c) Drastic Actions. All rights reserved.
// </copyright>

using DA.UI.Commands;
using DA.UI.Services;
using DA.UI.ViewModels;

namespace StableDiffusionMaui.ViewModels;

public class PromptViewModel : BaseViewModel
{
    private IAsyncCommand pickModelCommand;
    private string promptText = string.Empty;
    private string modelPath = string.Empty;

    public PromptViewModel(IAppDispatcher dispatcher, IErrorHandler errorHandler, IAsyncCommandFactory asyncCommandFactory)
        : base(dispatcher, errorHandler, asyncCommandFactory)
    {
        this.pickModelCommand = this.CommandFactory.Create("Test", this.PickModelAsync, () => !this.IsBusy);
    }

    public IAsyncCommand PickModelCommand => this.pickModelCommand;

    public string PromptText
    {
        get => this.promptText;
        set => this.SetProperty(ref this.promptText, value);
    }

    public string ModelPath
    {
        get => this.modelPath;
        set => this.SetProperty(ref this.modelPath, value);
    }

    private async Task PickModelAsync(CancellationToken x, IProgress<int> y, IProgress<string> z)
    {
        var pickOptions = new PickOptions();
        var result = await FilePicker.Default.PickAsync(pickOptions);
        if (result != null)
        {
            this.ModelPath = result.FullPath;
        }
    }
}