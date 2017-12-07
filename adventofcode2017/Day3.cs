//using System;
//namespace adventofcode2017
//{
//    public class Day3
//    {
//        string input;

//        public Day3()
//        {
//            input = new InputReader(3).Read();
//        }

//        public string Solve()
//        {
//            input = "12";
//            var intInput = int.Parse(input);
//            var rowCount = (int)Math.Sqrt(intInput);

//            var matrix = new int[rowCount, rowCount];

//            var x = rowCount / 2;
//            var y = x;
//            var n = 1;

//            matrix[x, y] = n;

//            while (x < rowCount && y < rowCount) {
//                matrix[++x, y] = ++n;
//                matrix[x, --y] = ++n;
//                matrix[--x, y] = ++n;
//                matrix[]
//            }

//            return "";
//        }
//    }
//}
