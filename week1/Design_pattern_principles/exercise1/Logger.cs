using System;

public sealed class Logger
{
    private static readonly object lockObj = new object();
    private static Logger? instance = null;

    private Logger()
    {
        Console.WriteLine("Logger initialized");
    }

    public static Logger GetInstance()
    {
        if (instance == null)
        {
            lock (lockObj)
            {
                if (instance == null)
                {
                    instance = new Logger();
                }
            }
        }
        return instance;
    }

    public void Log(string message)
    {
        Console.WriteLine("LOG: " + message);
    }
}
