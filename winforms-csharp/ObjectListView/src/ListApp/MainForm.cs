using BrightIdeasSoftware;

using System.Collections.Generic;
using System.Windows.Forms;

namespace ListApp
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();

            mainObjectListView.ShowGroups = false;
            //mainObjectListView.HeaderStyle = ColumnHeaderStyle.None;
            mainObjectListView.View = View.Details;

            var column = new OLVColumn
            {
                Text = "Контент",
                AspectGetter = obj =>
                {
                    var model = obj as Model;
                    return model?.DisplayContent;
                },
                Renderer = new ModelRenderer(),
            };
            mainObjectListView.Columns.Add(column);

            var items = new List<Model>
            {
                new Model { Text = "Текст 1" },
                //new Model { Image = Image.FromFile(Environment.CurrentDirectory + @"\1.bmp") },
                new Model { Text = "Текст 2" },
            };
            mainObjectListView.SetObjects(items);
        }
    }
}
