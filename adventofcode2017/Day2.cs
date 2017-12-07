
using System;
using System.Collections.Generic;
using System.Linq;

namespace adventofcode2017
{
    public class Day2
    {
        readonly string input;

        public Day2()
        {
            input = new InputReader(2).Read();
        }

        public string Solve() {
            var lines = input.Split('\n');
            var intLines = new List<int[]>();
            foreach (var line in lines)
            {
                var temp = line.Split('\t');
                intLines.Add(temp.Select(c => int.Parse(c)).ToArray());
            }

            var difs = new List<int>(intLines.Count);
            foreach (var intLine in intLines)
            {
                var min = intLine.Min();
                var max = intLine.Max();
                difs.Add(max - min);
            }

            return difs.Sum().ToString();
        }
    }
}
