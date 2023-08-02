using System;
using System.Collections.Generic;

using Dock.Avalonia.Controls;
using Dock.Model.Controls;
using Dock.Model.Core;
using Dock.Model.Mvvm;
using Dock.Model.Mvvm.Controls;

using DockingApplication.ViewModels.Docks;
using DockingApplication.ViewModels.Documents;
using DockingApplication.ViewModels.Toolbars;

namespace DockingApplication.ViewModels;

public class AppFactory : Factory {
    private IRootDock? _rootDock;
    private IDocumentDock? _documentDock;
    private ITool? _inputToolbar;
    private ITool? _listToolbar;

    public override IDocumentDock CreateDocumentDock() => new FileDocumentDock();

    public override IRootDock CreateLayout() {
        var untitledFileViewModel = new FileViewModel() {
            Title = "Untitled",
            Text = "",
        };

        var inputViewModel = new InputViewModel {
            Id = "Input",
            Title = "Input"
        };
        var listViewModel = new ListViewModel {
            Id = "List",
            Title = "List"
        };

        var documentDock = new FileDocumentDock() {
            Id = "Files",
            Title = "Files",
            IsCollapsable = false,
            Proportion = double.NaN,
            ActiveDockable = untitledFileViewModel,
            VisibleDockables = CreateList<IDockable>(untitledFileViewModel),
            CanCreateDocument = true
        };

        var tools = new ProportionalDock {
            Proportion = 0.2,
            Orientation = Orientation.Vertical,
            VisibleDockables = CreateList<IDockable>(
                new ToolDock {
                    ActiveDockable = inputViewModel,
                    VisibleDockables = CreateList<IDockable>(inputViewModel),
                    Alignment = Alignment.Right,
                    GripMode = GripMode.Visible
                },
                new ProportionalDockSplitter(),
                new ToolDock {
                    ActiveDockable = listViewModel,
                    VisibleDockables = CreateList<IDockable>(listViewModel),
                    Alignment = Alignment.Right,
                    GripMode = GripMode.Visible
                }
            )
        };

        var windowLayout = CreateRootDock();
        windowLayout.Title = "Default";
        var windowLayoutContent = new ProportionalDock {
            Orientation = Orientation.Horizontal,
            IsCollapsable = false,
            VisibleDockables = CreateList<IDockable>(
                documentDock,
                new ProportionalDockSplitter(),
                tools
            )
        };
        windowLayout.IsCollapsable = false;
        windowLayout.VisibleDockables = CreateList<IDockable>(windowLayoutContent);
        windowLayout.ActiveDockable = windowLayoutContent;

        var rootDock = CreateRootDock();
        rootDock.IsCollapsable = false;
        rootDock.VisibleDockables = CreateList<IDockable>(windowLayout);
        rootDock.ActiveDockable = windowLayout;
        rootDock.DefaultDockable = windowLayout;

        _documentDock = documentDock;
        _rootDock = rootDock;
        _inputToolbar = inputViewModel;
        _listToolbar = listViewModel;

        return rootDock;
    }

    public override void InitLayout(IDockable layout) {
        ContextLocator = new Dictionary<string, Func<object?>> {
            ["Input"] = () => layout,
            ["List"] = () => layout
        };

        DockableLocator = new Dictionary<string, Func<IDockable?>> {
            ["Root"] = () => _rootDock,
            ["Files"] = () => _documentDock,
            ["Input"] = () => _inputToolbar,
            ["List"] = () => _listToolbar
        };

        HostWindowLocator = new Dictionary<string, Func<IHostWindow?>> {
            [nameof(IDockWindow)] = () => new HostWindow()
        };

        base.InitLayout(layout);
    }
}
