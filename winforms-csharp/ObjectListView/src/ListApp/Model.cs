using System.Drawing;

namespace ListApp
{
    public sealed class Model
    {
        public string Text { get; set; }
        public Image Image { get; set; }

        public object DisplayContent => Image ?? (object)Text;
    }
}
