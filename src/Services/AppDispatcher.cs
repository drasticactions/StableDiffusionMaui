// <copyright file="AppDispatcher.cs" company="Drastic Actions">
// Copyright (c) Drastic Actions. All rights reserved.
// </copyright>

using DA.UI.Services;

namespace StableDiffusionMaui.Services;

/// <summary>
/// App Dispatcher.
/// </summary>
public class AppDispatcher : IAppDispatcher
{
    /// <inheritdoc/>
    public bool Dispatch(Action action)
    {
        return Application.Current!.Dispatcher.Dispatch(action);
    }
}