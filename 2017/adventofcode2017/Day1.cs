using System;
using System.Collections.Generic;
using System.Linq;

namespace adventofcode2017
{
    public class Day1
    {
         string input;

        public Day1()
        {
            input = new InputReader(1).Read();
        }

        public string Solve() {
            var digits = new List<int>();
            for (int i = 1; i < input.Length; i++)
            {
                var j = i - 1;
                if (i + 1 == input.Length) {
                    j = 0; 
                }

                if (input[j] == input[i]) {
                    digits.Add(int.Parse(input[j].ToString()));
                }
            }


            return digits.Sum().ToString();
        }
    }
}
