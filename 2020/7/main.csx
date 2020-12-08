#!/usr/bin/env dotnet-script

Console.WriteLine("First Assignment!");

var myBag = "shiny gold";
var rules = File.ReadAllLines("input.txt")
                .Select(r => CreateRuleFromString(r.Trim()))
                .ToList();
var validBags = new HashSet<string>();
var bagsToCheck = new List<string>() { myBag };

for (int i = 0; i < bagsToCheck.Count; i++)
{
    for (int j = 0; j < rules.Count; j++)
    {
        if (rules[j].Contents.ContainsKey(bagsToCheck[i]))
        {
            if (validBags.Contains(rules[j].Name))
            {
                continue;
            }

            validBags.Add(rules[j].Name);
            bagsToCheck.Add(rules[j].Name);
        }
    }

    bagsToCheck.RemoveAt(i--);
}

Console.WriteLine($"{validBags.Count} bag colors can eventually contain at least one {myBag} bag");

Console.WriteLine("Second Assignment!");

var (verticies, edges) = CreateVerteciesFromRules(rules);
var bagCount = 0;

var visited = new List<(string, int)>();
var queue = new Queue<(string vertex, int weight)>();
queue.Enqueue((myBag, 1));
while (queue.Count > 0)
{
    var vertex = queue.Dequeue();
    visited.Add(new (vertex.vertex, vertex.weight));
    foreach (var edge in edges.Where(e => e.From == vertex.vertex))
    {
        queue.Enqueue(new (edge.To, edge.Weight * vertex.weight));
    }
}

Console.WriteLine($"{visited.Sum(v => v.Item2) - 1} individual bags are required inside your single {myBag} bag");

public Rule CreateRuleFromString(string s)
{
    var words = s.Split(' ');
    var name = $"{words[0]} {words[1]}";
    var contents = new Dictionary<string, int>();
    for (int i = 4; i < words.Length; i += 4)
    {
        if (int.TryParse(words[i], out int n))
        {
            contents.Add($"{words[i + 1]} {words[i + 2]}", n);
        }
        else
        {
            break;
        }
    }

    return new Rule(name, contents);
}

public (ICollection<string> verticies, ICollection<Vertex> edges) CreateVerteciesFromRules(IEnumerable<Rule> rules)
{
    var verticies = new List<string>();
    var edges = new List<Vertex>();
    foreach (var rule in rules)
    {
        verticies.Add(rule.Name);
        foreach (var kv in rule.Contents)
        {
            edges.Add(new Vertex(rule.Name, kv.Key, kv.Value));
        }
    }

    return new(verticies, edges);
}

public record Rule(string Name, Dictionary<string, int> Contents);
public record Vertex(string From, string To, int Weight);