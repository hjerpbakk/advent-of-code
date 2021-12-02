#!/usr/bin/env dotnet-script

var commands = File.ReadAllLines("input1.txt").Select(l => l.Split(' ')).Select(l => new Command(ToKind(l[0]), int.Parse(l[1])));

var position = new OldPosition(0, 0);
foreach (var command in commands)
{
    position = command.Kind switch {
        Kind.Forward => new OldPosition(position.Horizontal + command.Value, position.Depth),
        Kind.Down => new OldPosition(position.Horizontal, position.Depth + command.Value),
        Kind.Up => new OldPosition(position.Horizontal, position.Depth - command.Value),
        _ => throw new ArgumentException("Invalid value for command", nameof(command.Kind))
    };
}

Console.WriteLine($"Horizontal {position.Horizontal} Depth {position.Depth} Multiple {position.Horizontal * position.Depth}");

var newPosition = new Position(0, 0, 0);
foreach (var command in commands)
{
    newPosition = command.Kind switch {
        Kind.Forward => new Position(newPosition.Horizontal + command.Value, newPosition.Depth + newPosition.Aim * command.Value, newPosition.Aim),
        Kind.Down => new Position(newPosition.Horizontal, newPosition.Depth, newPosition.Aim + command.Value),
        Kind.Up => new Position(newPosition.Horizontal, newPosition.Depth, newPosition.Aim - command.Value),
        _ => throw new ArgumentException("Invalid value for command", nameof(command.Kind))
    };
}

Console.WriteLine($"Horizontal {newPosition.Horizontal} Depth {newPosition.Depth} Aim {newPosition.Aim} Multiple {newPosition.Horizontal * newPosition.Depth}");

Kind ToKind(string command) =>
    command switch {
        "forward" => Kind.Forward,
        "down" => Kind.Down,
        "up" => Kind.Up,
        _ => throw new ArgumentException("Invalid string value for command", nameof(command))
    };

public record Command(Kind Kind, int Value);

public record OldPosition(int Horizontal, int Depth);
public record Position(int Horizontal, int Depth, int Aim);

public enum Kind {
    Forward,
    Down,
    Up
}
