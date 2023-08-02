using CommunityToolkit.Mvvm.Input;

using Dock.Model.Mvvm.Controls;

using DockingApplication.ViewModels.Documents;

namespace DockingApplication.ViewModels.Docks;

public class FileDocumentDock : DocumentDock {
    private void CreateNewDocument() {
        if (!CanCreateDocument) {
            return;
        }
        var document = new FileViewModel() {
            Title = "Untitled",
            Text = "",
        };

        Factory?.AddDockable(this, document);
        Factory?.SetActiveDockable(document);
        Factory?.SetFocusedDockable(this, document);
    }

    public FileDocumentDock() {
        CreateDocument = new RelayCommand(CreateNewDocument);
    }
}
