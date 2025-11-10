using System;

namespace ConsoleApplication;

internal class Program
{
    private static void Main(string[] arguments)
    {
        foreach (var argument in arguments)
        {
            Console.WriteLine(argument);
        }

        try
        {
            throw new Exception("Empty exception message");
        }
        catch (Exception exception)
        {
            Console.WriteLine(exception.Message);
            Console.WriteLine(exception.StackTrace);
        }
    }
}
