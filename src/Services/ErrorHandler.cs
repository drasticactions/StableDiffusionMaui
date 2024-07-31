// <copyright file="ErrorHandler.cs" company="Drastic Actions">
// Copyright (c) Drastic Actions. All rights reserved.
// </copyright>

using DA.UI.Services;

namespace StableDiffusionMaui.Services;

/// <summary>
/// Global Error Handler.
/// </summary>
public class ErrorHandler : IErrorHandler
{
    /// <inheritdoc/>
    public void HandleError(Exception ex)
    {
        #if DEBUG
        System.Diagnostics.Debugger.Break();
        #endif
        System.Diagnostics.Debug.WriteLine(ex.Message);
    }
}
