#!/usr/bin/env dotnet-script

Console.WriteLine("First Assignment!");

var program = File.ReadAllLines("input.txt")
                  .Select(l => l.Trim().Split(' '))
                  .Select(l => new Operation(l[0], int.Parse(l[1])))
                  .ToArray();

var accumulator = 0;
var operations = new Dictionary<string, Func<int, int, int>>
{
    { "acc", (i, arg) => { accumulator += arg; return i + 1; } },
    { "jmp", (i, arg) => { return i + arg; } },
    { "nop", (i, arg) => { return i + 1; } }
};

var visitedOperations = new HashSet<int>();
int i = 0;
while (true)
{
    var op = program[i];
    i = operations[op.Code](i, op.Argument);
    if (visitedOperations.Contains(i)) {
        break;
    }

    visitedOperations.Add(i);
}

Console.WriteLine($"{accumulator} is the value of the accumulator");

Console.WriteLine("Second Assignment!");

accumulator = 0;
var checkedOperations = new HashSet<int>();
bool tryToChangeOps = false;
for (int i = 0; i < program.Length;)
{
    var op = program[i];
    if (tryToChangeOps && !checkedOperations.Contains(i)) {
        checkedOperations.Add(i);
        tryToChangeOps = false;
        if (op.Code == "jmp") {
            op = op with { Code = "nop" };
        } else if (op.Code == "nop") {
            op = op with { Code = "jmp" };
        } else {
            tryToChangeOps = true;
        }
    }

    i = operations[op.Code](i, op.Argument);
    if (visitedOperations.Contains(i)) {
        visitedOperations.Clear();
        i = 0;
        accumulator = 0;
        tryToChangeOps = true;
        continue;
    }

    visitedOperations.Add(i);
}

Console.WriteLine($"{accumulator} is the value of the accumulator");

public record Operation(string Code, int Argument);