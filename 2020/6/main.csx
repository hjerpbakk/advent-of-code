#!/usr/bin/env dotnet-script

Console.WriteLine("First Assignment!");

var groups = File.ReadAllText("input.txt")
                 .Split("\n\n", StringSplitOptions.RemoveEmptyEntries)
                 .Select(s => new Group(s.Split('\n').ToArray()))
                 .ToArray();

var sumOfCorrectAnswers = 0;

foreach (var group in groups)
{
    var correctAswers = new List<char>();
    foreach (var answers in group.Answers)
    {
        foreach (var answer in answers)
        {
            if (!correctAswers.Contains(answer))
            {
                correctAswers.Add(answer);
            }
        }
    }

    sumOfCorrectAnswers += correctAswers.Count;
}

Console.WriteLine($"Sum of correct answers: {sumOfCorrectAnswers}");

Console.WriteLine("Second Assignment!");

sumOfCorrectAnswers = 0;

foreach (var group in groups)
{
    var correctAswers = new Dictionary<char, int>();
    foreach (var answers in group.Answers)
    {
        foreach (var answer in answers)
        {
            if (!correctAswers.ContainsKey(answer))
            {
                correctAswers.Add(answer, 1);
            } else {
                correctAswers[answer]++;
            }
        }
    }

    sumOfCorrectAnswers += correctAswers.Values.Count(v => v == group.Answers.Length);
}

Console.WriteLine($"Sum of correct answers: {sumOfCorrectAnswers}");

public record Group(string[] Answers);