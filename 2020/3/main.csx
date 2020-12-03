#!/usr/bin/env dotnet-script

var input = File.ReadAllLines("input.txt").Select(l => l.Trim()).ToArray();
// Poor mans landscaping
var lines = new string[input.Length];
for (int i = 0; i < input.Length; i++)
{
    for (int j = 0; j < input.Length; j++)
    {
        lines[i] += input[i];
    }
}

Console.WriteLine("First");
(int x, int y) position = (0, 0);
long numberOfTrees = GetTheNumberOfTrees(3, 1);

Console.WriteLine("Second");
numberOfTrees = GetTheNumberOfTrees(1, 1);
numberOfTrees *= GetTheNumberOfTrees(3, 1);
numberOfTrees *= GetTheNumberOfTrees(5, 1);
numberOfTrees *= GetTheNumberOfTrees(7, 1);
numberOfTrees *= GetTheNumberOfTrees(1, 2);
Console.WriteLine("Product: " + numberOfTrees);

public int GetTheNumberOfTrees(int right, int down)
{
    position = (0, 0);
    var numberOfTrees = 0;
    while (position.y < lines.Length - 1)
    {
        var tile = Slope(right, down);
        if (tile == '#')
        {
            numberOfTrees++;
        }
    }

    Console.WriteLine("Number of Trees:" + numberOfTrees);
    return numberOfTrees;
}

public char Slope(int right, int down)
{
    position = (position.x + right, position.y + down);
    return lines[position.y][position.x];
}
