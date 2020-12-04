#!/usr/bin/env dotnet-script

#r "nuget: System.Text.RegularExpressions, 4.3.1"

using System.Text.RegularExpressions;

var input = File.ReadAllText("input.txt")
                .Split("\n\n", StringSplitOptions.RemoveEmptyEntries)
                .Select(l => l.Replace("\n", " "))
                .Select(l => l.Trim())
                .ToArray();
var passports = new Dictionary<string, string>[input.Length];
for (int i = 0; i < input.Length; i++)
{
    var keysAndValues = input[i].Split(' ', StringSplitOptions.RemoveEmptyEntries);
    passports[i] = new Dictionary<string, string>(keysAndValues
        .Select(kv => kv.Split(':', StringSplitOptions.RemoveEmptyEntries))
        .Select(kv => new KeyValuePair<string, string>(kv[0], kv[1])));
}

var mandatoryFields = new[] { "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" };
var optionalFields = new[] { "cid" };

Console.WriteLine("First assignment");
var numberOfValidPassports = 0;
foreach (var passport in passports)
{
    var valid = true;
    foreach (var field in mandatoryFields)
    {
        if (!passport.ContainsKey(field))
        {
            valid = false;
            break;
        }
    }

    if (valid)
    {
        numberOfValidPassports++;
    }
}

Console.WriteLine(numberOfValidPassports);

Console.WriteLine("Second assignment");

numberOfValidPassports = 0;
foreach (var passport in passports)
{
    var valid = true;
    foreach (var field in mandatoryFields)
    {
        if (!valid)
        {
            break;
        }

        if (!passport.ContainsKey(field))
        {
            valid = false;
            break;
        }
        else
        {
            var value = passport[field];
            switch (field)
            {
                case "byr":
                    valid = ValidateNumber(value, 1920, 2002);
                    break;
                case "iyr":
                    valid = ValidateNumber(value, 2010, 2020);
                    break;
                case "eyr":
                    valid = ValidateNumber(value, 2020, 2030);
                    break;
                case "hgt":
                    if (value.EndsWith("cm") && value.Length == 5) {
                        var height = value[..3];
                        valid = ValidateNumber(height, 150, 193);
                    } else if (value.EndsWith("in") && value.Length == 4) {
                        var height = value[..2];
                        valid = ValidateNumber(height, 59, 76);
                    } else {
                        valid = false;
                    }

                    break;
                case "hcl":
                    var regex = new Regex("#([0-9]|[a-f]){6,}");
                    if (value.Length != 7 || !regex.IsMatch(value)) {
                        valid = false;
                    }

                    break;
                case "ecl":
                    valid = new[] { "amb", "blu", "brn", "gry", "grn", "hzl", "oth"}.Contains(value);
                    break;
                case "pid":
                    regex = new Regex("([0-9]){9}");
                    if (value.Length != 9 || !regex.IsMatch(value)) {
                        valid = false;
                    }

                    break;
            }
        }
    }

    if (valid)
    {
        numberOfValidPassports++;
    }
}

Console.WriteLine(numberOfValidPassports);

public bool ValidateNumber(string s, int lowerBound, int upperBound)
{
    if (int.TryParse(s, out int expYear))
    {
        if (expYear < lowerBound || expYear > upperBound)
        {
            return false;
        }

        return true;
    }
    else
    {
        return false;
    }
}
