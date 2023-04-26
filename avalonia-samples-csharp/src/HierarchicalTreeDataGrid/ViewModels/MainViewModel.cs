using System.Collections.ObjectModel;

using Avalonia.Controls;
using Avalonia.Controls.Models.TreeDataGrid;

using CommunityToolkit.Mvvm.ComponentModel;

using HierarchicalTreeDataGrid.Models;

namespace HierarchicalTreeDataGrid.ViewModels;

public class MainViewModel : ObservableObject {
    private ObservableCollection<Person> _people = new() {
        new Person {
            FirstName = "Eleanor",
            LastName = "Pope",
            Age = 32,
            Children = {
                new Person {
                    FirstName = "Marcel",
                    LastName = "Gutierrez",
                    Age = 4,
                },
            },
        },
        new Person {
            FirstName = "Jeremy",
            LastName = "Navarro",
            Age = 74,
            Children = {
                new Person {
                    FirstName = "Jane",
                    LastName = "Navarro",
                    Age = 42,
                    Children = {
                        new Person {
                            FirstName = "Lailah",
                            LastName = "Velazquez",
                            Age = 16,
                        },
                    },
                },
            },
        },
        new Person {
            FirstName = "Jazmine",
            LastName = "Schroeder",
            Age = 52,
        },
    };

    public HierarchicalTreeDataGridSource<Person> Source { get; }

    public MainViewModel() {
        Source = new HierarchicalTreeDataGridSource<Person>(_people) {
            Columns = {
                new HierarchicalExpanderColumn<Person>(
                    new TextColumn<Person, string>("First Name", x => x.FirstName),
                    x => x.Children),
                new TextColumn<Person, string>("Last Name", x => x.LastName),
                new TextColumn<Person, int>("Age", x => x.Age),
            },
        };
    }
}
