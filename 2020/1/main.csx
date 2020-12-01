#!/usr/bin/env dotnet-script

var input = File.ReadAllText("input.txt");
var numbers = input.Split(Environment.NewLine, StringSplitOptions.RemoveEmptyEntries).Select(s => int.Parse(s)).ToArray();

FirstExercise();
SecondExercise();

void FirstExercise()
{
    for (int i = 0; i < numbers.Length; i++)
    {
        for (int j = 0; j < numbers.Length; j++)
        {
            if (numbers[i] + numbers[j] == 2020)
            {
                Console.WriteLine(numbers[i] * numbers[j]);
                return;
            }
        }
    }
}

void SecondExercise()
{
    for (int i = 0; i < numbers.Length; i++)
    {
        for (int j = 0; j < numbers.Length; j++)
        {
            for (int k = 0; k < numbers.Length; k++)
            {
                if (numbers[i] + numbers[j] + numbers[k] == 2020)
                {
                    Console.WriteLine(numbers[i] * numbers[j] * numbers[k]);
                    return;
                }
            }

        }
    }
}
