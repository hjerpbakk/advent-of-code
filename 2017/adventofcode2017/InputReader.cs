using System;
using System.IO;
using System.Reflection;

namespace adventofcode2017
{
    public class InputReader
    {
        readonly uint day;
        readonly string path;

        public InputReader(uint day)
        {
            this.day = day;
            path = $"{Directory.GetCurrentDirectory()}/input/{day}.txt";

           
        }

        public string Read() => File.ReadAllText(path);
    }
}
