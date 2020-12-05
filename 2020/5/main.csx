#!/usr/bin/env dotnet-script

var boardingPasses = File.ReadAllLines("input.txt")
                .Select(b => b.Trim())
                .ToArray();

Console.WriteLine("First assignment!");
var rowOperations = new Dictionary<char, Func<RowOrColumn, RowOrColumn>>();
rowOperations.Add('F', (r) => KeepLower(r));
rowOperations.Add('B', (r) => KeepUpper(r));

var columnOperations = new Dictionary<char, Func<RowOrColumn, RowOrColumn>>();
columnOperations.Add('R', (r) => KeepUpper(r));
columnOperations.Add('L', (r) => KeepLower(r));

var seats = new Dictionary<int, Seat>(boardingPasses.Length);
foreach (var boardingPass in boardingPasses)
{
    var row = new RowOrColumn(0, 127);
    var column = new RowOrColumn(0, 7);
    foreach (var letter in boardingPass)
    {
        if (rowOperations.ContainsKey(letter))
        {
            row = rowOperations[letter](row);
        } else if (columnOperations.ContainsKey(letter)) {
            column = columnOperations[letter](column);
        }
    }

    var seat = new Seat() { Row = row.Lower, Column = column.Lower };
    seats.Add(seat.Id, seat);
    Console.WriteLine(seat);
}

Console.WriteLine($"Highest seat Id: {seats.Values.Max(s => s.Id)}");

Console.WriteLine("Second assignment!");

var plusOneNeighbour = seats.Values.Single(s => HasFreeAdjecentId(seats, s));
Console.WriteLine($"+1 from me: {plusOneNeighbour}");
var minusOneNeighbour = seats[plusOneNeighbour.Id - 2];
Console.WriteLine($"-1 from me: {minusOneNeighbour}");

Console.WriteLine($"My seat Id: {plusOneNeighbour with { Column = plusOneNeighbour.Column - 1}}");

public RowOrColumn KeepLower(RowOrColumn row) => row with { Upper = row.Upper - ((row.Upper - row.Lower) / 2) - 1 };

public RowOrColumn KeepUpper(RowOrColumn row) => row with { Lower = row.Lower + ((row.Upper - row.Lower) / 2) + 1 };

public bool HasFreeAdjecentId(Dictionary<int, Seat> seats, Seat seat) => seats.ContainsKey(seat.Id - 2) && !seats.ContainsKey(seat.Id - 1);

public record RowOrColumn(int Lower, int Upper);

public record Seat
{
    public int Row { get; init; }
    public int Column { get; init; }
    public int Id => Row * 8 + Column;
}