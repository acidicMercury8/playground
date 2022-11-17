using Microsoft.EntityFrameworkCore;

namespace SwaggerWebApplication.Models;

public class TodoContext : DbContext {
    public TodoContext(DbContextOptions<TodoContext> options) : base(options) { }

    public DbSet<TodoItem> TodoItems => Set<TodoItem>();
}
