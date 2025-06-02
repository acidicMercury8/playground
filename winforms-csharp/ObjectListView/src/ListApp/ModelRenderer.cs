using BrightIdeasSoftware;

using System;
using System.Drawing;

namespace ListApp
{
    public class ModelRenderer : BaseRenderer
    {
        public override void Render(Graphics graphics, Rectangle rectangle)
        {
            var backgroundColor = GetBackgroundColor();
            graphics.Clear(backgroundColor);

            var content = Aspect;
            if (content is Image image)
            {
                float ratio = Math.Min(
                    (float)rectangle.Width / image.Width,
                    (float)rectangle.Height / image.Height
                );

                int newWidth = (int)(image.Width * ratio);
                int newHeight = (int)(image.Height * ratio);
                graphics.DrawImage(
                    image,
                    rectangle.X + (rectangle.Width - newWidth) / 2,
                    rectangle.Y + (rectangle.Height - newHeight) / 2,
                    newWidth,
                    newHeight
                );

                return;
            }

            if (content is string text)
            {
                var format = new StringFormat
                {
                    Alignment = StringAlignment.Near,
                    LineAlignment = StringAlignment.Center,
                    Trimming = StringTrimming.EllipsisCharacter
                };

                using (var brush = new SolidBrush(GetForegroundColor()))
                {
                    graphics.DrawString(text, Font, brush, rectangle, format);
                }
            }

            base.Render(graphics, rectangle);
        }
    }
}
