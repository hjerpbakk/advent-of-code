#!/usr/bin/env dotnet-script

Console.WriteLine("First Assignment!");

var input = File.ReadAllLines("testinput.txt")
                .Select(l => int.Parse(l.Trim()));
var joltages = new[] { 0 }.Concat(input).Concat(new[] { input.Max() + 3 }).OrderBy(i => i).ToArray();

var oneJoltDifferences = 0;
var threeJoltDifferences = 0;
var prevJoltage = joltages[0];
for (int i = 1; i < joltages.Length; i++)
{
    var dif = joltages[i] - prevJoltage;
    if (dif == 1)
    {
        oneJoltDifferences++;
    }
    else if (dif == 3)
    {
        threeJoltDifferences++;
    }

    prevJoltage = joltages[i];
}

Console.WriteLine($"{oneJoltDifferences * threeJoltDifferences} is the number of 1-jolt differences multiplied by the number of 3-jolt differences");

Console.WriteLine("Second Assignment!");

long combinations = 0;
prevJoltage = joltages[0];
var combos = new List<List<int>>();
var a  = new List<int>();
for (int i = 1; i < joltages.Length; i++)
{

    // TODO: Må ha en utforskende tilnærming, på hvert steg, 
    // bytt ut med gyldig alternativer og prøv også disse på nytt om muligheter oppstår.
    // Alle muilgheter som kjørte til enden, er gyldige og må addes opp...


    a.Add(joltages[i]);
    var dif = joltages[i] - prevJoltage;
    if (dif > 3)
    {
        break;
    }

    bool newCombo = true;
    var tempPrevJoltage = prevJoltage;
    var c = new List<int>();
    for (int j = i + 1; j < joltages.Length; j++)
    {
        c.AddRange(a);
        c.Add(joltages[j]);
        dif = joltages[j] - tempPrevJoltage;
        if (dif > 3)
        {
            c = null;
            newCombo = false;
            break;
        }

        tempPrevJoltage = joltages[j];
    }

    if (newCombo) {
        combinations++;
        if (c != null) {
            combos.Add(c);
        }
    }

    prevJoltage = joltages[i];
}

combos.Add(a);
combinations++;
Console.WriteLine($"{combinations} is the total number of distinct ways you can arrange the adapters to connect the charging outlet to your device");