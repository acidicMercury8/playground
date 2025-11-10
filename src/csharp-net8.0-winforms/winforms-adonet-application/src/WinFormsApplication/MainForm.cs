using Microsoft.Data.Sqlite;

namespace WinFormsApplication;

public partial class MainForm : Form
{
    private static readonly string databasePath =
        Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "library.db");

    private static readonly string connectionString =
        $"Data Source={databasePath}";

    public MainForm()
    {
        InitializeComponent();
    }

    private void MainForm_Load(object sender, EventArgs e)
    {
        using var connection = new SqliteConnection(connectionString);
        connection.Open();

        string createTableQuery = """
            CREATE TABLE IF NOT EXISTS books (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                author TEXT NOT NULL,
                year INTEGER,
                genre TEXT,
                status TEXT DEFAULT 'в наличии', -- 'в наличии', 'прочитана'
                created_at DATETIME
            );
        """;
        using var createCommand = new SqliteCommand(createTableQuery, connection);
        createCommand.ExecuteNonQuery();

        string checkDataQuery = "SELECT COUNT(*) FROM books;";
        using var checkCommand = new SqliteCommand(checkDataQuery, connection);
        var rowCount = (long)checkCommand.ExecuteScalar()!;

        if (rowCount == 0)
        {
            string insertValuesQuery = """
                INSERT INTO books (title, author, year, genre, status) VALUES
                ('Мастер и Маргарита', 'Булгаков М.А.', 1966, 'Роман', 'прочитана'),
                ('Преступление и наказание', 'Достоевский Ф.М.', 1866, 'Роман', 'в наличии'),
                ('Война и мир', 'Толстой Л.Н.', 1869, 'Роман', 'прочитана'),
                ('1984', 'Оруэлл Джордж', 1949, 'Антиутопия', 'в наличии'),
                ('Гарри Поттер и философский камень', 'Роулинг Дж.К.', 1997, 'Фэнтези', 'в наличии'),
                ('Маленький принц', 'Сент-Экзюпери А.', 1943, 'Притча', 'прочитана'),
                ('Три товарища', 'Ремарк Э.М.', 1936, 'Роман', 'в наличии'),
                ('Шерлок Холмс', 'Конан Дойл А.', 1892, 'Детектив', 'отдана'),
                ('Анна Каренина', 'Толстой Л.Н.', 1877, 'Роман', 'в наличии'),
                ('Сто лет одиночества', 'Маркес Г.Г.', 1967, 'Роман', 'прочитана');
            """;
            using var insertCommand = new SqliteCommand(insertValuesQuery, connection);
            insertCommand.ExecuteNonQuery();
        }
    }

    private void SelectButton_Click(object sender, EventArgs e)
    {
        using var connection = new SqliteConnection(connectionString);
        connection.Open();

        logTextBox.Text = string.Empty;

        string selectValuesQuery = """
            SELECT *
            FROM books
            WHERE author LIKE '%Толстой%';
        """;
        using var selectCommand = new SqliteCommand(selectValuesQuery, connection);
        using var selectReader = selectCommand.ExecuteReader();
        while (selectReader.Read())
        {
            logTextBox.Text += $"ID: {selectReader["id"]}\r\n";
            logTextBox.Text += $"Название: {selectReader["title"]}\r\n";
            logTextBox.Text += $"Автор: {selectReader["author"]}\r\n";
            logTextBox.Text += $"Год: {selectReader["year"]}\r\n";
            logTextBox.Text += $"Жанр: {selectReader["genre"]}\r\n";
            logTextBox.Text += $"Статус: {selectReader["status"]}\r\n";
            logTextBox.Text += $"Дата добавления: {selectReader["created_at"]}\r\n";
            logTextBox.Text += "\r\n";
        }
    }
}
