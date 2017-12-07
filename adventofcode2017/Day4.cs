using System;
using System.Linq;

namespace adventofcode2017
{
    public class Day4
    {
        readonly string input;

        public Day4()
        {
            input = new InputReader(4).Read();
        }

        public string Solve()
        {
            var lines = input.Split('\n');
            int n = 0;
            foreach (var line in lines)
            {
                var valid = IsValidPassPhrase(line);
                if (valid) {
                    ++n;
                }
            }

            return n.ToString();
        }

        bool IsValidPassPhrase(string phrase) {
            var words = phrase.Split(' ');
            return words.Distinct().Count() == words.Length;
        }
    }
}
