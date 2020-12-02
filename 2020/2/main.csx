#!/usr/bin/env dotnet-script

var lines = File.ReadAllLines("input.txt").Select(line => CreateLine(line)).ToArray();

var validPasswords = 0;
foreach (var line in lines)
{
    var occurences = line.Password.Count(c => c == line.PasswordPolicy.Letter);
    if (occurences >= line.PasswordPolicy.Min && occurences <= line.PasswordPolicy.Max)
    {
        validPasswords++;
    }
}

Console.WriteLine(validPasswords);

validPasswords = 0;
foreach (var line in lines)
{
    var inRange = InRange(line.PasswordPolicy.Min) && InRange(line.PasswordPolicy.Max);
    var firstOption = line.Password[line.PasswordPolicy.Min - 1] == line.PasswordPolicy.Letter && line.Password[line.PasswordPolicy.Max - 1] != line.PasswordPolicy.Letter;
    var secondOption = line.Password[line.PasswordPolicy.Min - 1] != line.PasswordPolicy.Letter && line.Password[line.PasswordPolicy.Max - 1] == line.PasswordPolicy.Letter;
    if (inRange && (firstOption || secondOption))
    {
        validPasswords++;
    }

    bool InRange(int n) => n > 0 && n <= line.Password.Length;
}

Console.WriteLine(validPasswords);

public record PasswordPolicy(char Letter, int Min, int Max);
public record Line(PasswordPolicy PasswordPolicy, string Password);

public Line CreateLine(string line)
{
    var parts = line.Split(':');
    var policyParts = parts[0].Split(' ');
    var policyPart = policyParts[0].Split('-');
    return new Line(new PasswordPolicy(policyParts[1][0], int.Parse(policyPart[0]), int.Parse(policyPart[1])), parts[1].Trim());
}
