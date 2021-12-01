#!/usr/bin/env dotnet-script

Console.WriteLine("First Assignment!");

const char Floor = '.';
const char Empty = 'L';
const char Occupied = '#';
var waitingRoom = File.ReadAllLines("testinput.txt")
                .Select((l => l.Trim().ToCharArray()))
                .ToList();

// - If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
// - If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
// Otherwise, the seat's state does not change.
// - Floor (.) never changes; seats don't move, and nobody sits on the floor.

List<char[]> nextWaitingRoom;
int numberOfOccupiedSeats;
var prev = -1;
var numberOfStableIterations = 0;
while (true)
{
    //Print();
    numberOfOccupiedSeats = 0;
    nextWaitingRoom = new List<char[]>();
    foreach (var row in waitingRoom)
    {
        var newLine = new char[row.Length];
        row.CopyTo(newLine, 0);
        nextWaitingRoom.Add(newLine);
    }

    for (int i = 0; i < waitingRoom.Count; i++)
    {
        for (int j = 0; j < waitingRoom[i].Length; j++)
        {
            if (SetOccupiedIfNeeded(i, j))
            {
                continue;
            }
            
            SetEmptyIfNeeded(i, j);

            if (nextWaitingRoom[i][j] == Occupied) {
                numberOfOccupiedSeats++;
            }
        }
    }

    waitingRoom = nextWaitingRoom;
    if (numberOfOccupiedSeats == prev) {
        numberOfStableIterations++;
        if (numberOfStableIterations > 100) {
            break;
        }
    }

    prev = numberOfOccupiedSeats;
}

Console.WriteLine($"{numberOfOccupiedSeats} occupied seats");

Console.WriteLine("Second Assignment!");

numberOfOccupiedSeats = 0;

Console.WriteLine($"{numberOfOccupiedSeats} occupied seats");

public bool SetOccupiedIfNeeded(int i, int j)
{
    if (nextWaitingRoom[i][j] == Empty && NumberOfOccupiedAdjecentSeats(i, j) == 0)
    {
        nextWaitingRoom[i][j] = Occupied;
        return true;
    }

    return false;
}

public void SetEmptyIfNeeded(int i, int j)
{
    if (nextWaitingRoom[i][j] == Occupied && NumberOfOccupiedAdjecentSeats(i, j) > 3)
    {
        nextWaitingRoom[i][j] = Empty;
    }
}

public int NumberOfOccupiedAdjecentSeats(int i, int j)
{
    var positionsToCheck = GetPositionsToCheck(i, j);
    var n = 0;
    foreach (var position in positionsToCheck)
    {
        if (position.i >= 0 &&
            position.i < waitingRoom.Count &&
            position.j >= 0 &&
            position.j < waitingRoom[0].Length &&
            waitingRoom[position.i][position.j] == Occupied)
        {
            n++;
        }
    }

    return n;
}

public (int i, int j)[] GetPositionsToCheck(int i, int j) =>
    new (int i, int j)[] {
        new (i - 1, j - 1),
        new (i, j - 1),
        new (i + 1, j - 1),
        new (i + 1, j),
        new (i + 1, j + 1),
        new (i, j + 1),
        new (i - 1, j + 1),
        new (i - 1, j)
    };

public void Print() {
    Console.WriteLine();
    foreach (var line in waitingRoom)
    {
        var s = new string(line);
        Console.WriteLine(s);
    }
}