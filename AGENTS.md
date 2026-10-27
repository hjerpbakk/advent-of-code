# Advent of Code

My solutions to the yearly Advent of Code puzzles. Each year is its own project in a different stack, so there is no shared build.

## Layout

- `2017/`: C# solution (`adventofcode2017.sln`, netcoreapp2.0), one `DayN.cs` per day.
- `2020/` and `2021/`: one folder per day with `main.csx` (C# script), `assignment.txt`, `input.txt` and sometimes `testinput.txt`. Run with `dotnet-script main.csx` from the day folder.
- `2023/`: Xcode project `AdventOfCode2023.xcodeproj`, one `N.swift` per day, puzzle inputs in `Inputs/` as Swift files.
- `2024/advent-of-code-2024/`: Xcode command line project, one `N.swift` per day plus `main.swift`.

## Build and test

```bash
xcodebuild -project 2023/AdventOfCode2023.xcodeproj -scheme AdventOfCode2023 -destination 'platform=macOS' -quiet build
dotnet build 2017/adventofcode2017.sln
```

There are no tests. Puzzle inputs are committed next to the code, so keep them there.
