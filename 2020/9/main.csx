#!/usr/bin/env dotnet-script

Console.WriteLine("First Assignment!");

const int PreambleLength = 25;

var xmas = File.ReadAllLines("input.txt")
               .Select(l => long.Parse(l.Trim()))
               .ToArray();
var firstNotSumOfTwoPreceedingNumbers = 0L;

for (int i = PreambleLength; i < xmas.Length; i++)
{
    bool sumOk = false;
    for (int j = i - PreambleLength; j < i; j++)
    {
        for (int k = i - PreambleLength; k < i; k++)
        {
            if (sumOk)
            {
                break;
            }

            if (xmas[i] == xmas[j] + xmas[k])
            {
                sumOk = true;
            }
        }

        if (sumOk)
        {
            break;
        }
    }

    if (!sumOk)
    {
        firstNotSumOfTwoPreceedingNumbers = xmas[i];
        break;
    }
}

Console.WriteLine($"{firstNotSumOfTwoPreceedingNumbers} is not the sum of two of the {PreambleLength} numbers before it.");

Console.WriteLine("Second Assignment!");

long encryptionWeakness = 0L;
var acc = 0L;
var start = 0;
for (int i = 0 + start; i < xmas.Length; i++)
{
    acc += xmas[i];
    if (acc == firstNotSumOfTwoPreceedingNumbers)
    {
        var nums = xmas.Skip(start).Take(i - start);
        encryptionWeakness = nums.Max() + nums.Min();
        break;
    }
    else if (acc > firstNotSumOfTwoPreceedingNumbers)
    {
        acc = 0L;
        i = start++;
    }
}

Console.WriteLine($"{encryptionWeakness} is the encryption weakness in your XMAS-encrypted list of numbers.");