#!/usr/bin/env dotnet-script

var input = File.ReadAllLines("input1.txt").Select(c => int.Parse(c)).ToArray();
var increased = 0;
for (int i = 1; i < input.Length; i++)
{
    if (input[i] > input[i - 1]) {
        ++increased;
    }
}

Console.WriteLine(increased);



increased = 0;
for (int i = 0; i < input.Length - 3; i++)
{
    var theOne = input[i] + input[i + 1] + input[i + 2];
    var theNext = input[i + 1] + input[i + 2] + input[i + 3];

    Console.WriteLine(theOne);
    if (theNext > theOne) {
        ++increased;
    }
}

Console.WriteLine(increased);