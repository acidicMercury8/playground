namespace WinFormsApplication
{
    partial class MainForm
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            selectButton = new Button();
            logTextBox = new TextBox();
            SuspendLayout();
            // 
            // selectButton
            // 
            selectButton.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            selectButton.Location = new Point(12, 243);
            selectButton.Name = "selectButton";
            selectButton.Size = new Size(75, 23);
            selectButton.TabIndex = 0;
            selectButton.Text = "Извлечь";
            selectButton.UseVisualStyleBackColor = true;
            selectButton.Click += SelectButton_Click;
            // 
            // logTextBox
            // 
            logTextBox.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            logTextBox.Location = new Point(12, 12);
            logTextBox.Multiline = true;
            logTextBox.Name = "logTextBox";
            logTextBox.ScrollBars = ScrollBars.Both;
            logTextBox.Size = new Size(472, 225);
            logTextBox.TabIndex = 1;
            // 
            // MainForm
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(496, 278);
            Controls.Add(logTextBox);
            Controls.Add(selectButton);
            Name = "MainForm";
            Text = "Form";
            Load += MainForm_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button selectButton;
        private TextBox logTextBox;
    }
}
