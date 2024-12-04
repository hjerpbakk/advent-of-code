import Foundation

func measureExecutionTime<T>(for function: () -> T, label: String) -> T {
    let start = Date()
    let result = function()
    let end = Date()
    
    let timeInterval = end.timeIntervalSince(start)
    let milliseconds = timeInterval * 1000
    let formattedTime = String(format: "%.3f", milliseconds)
    
    print(result)
    print("\(label) finished in \(formattedTime) ms")
    print()
    
    return result
}

let result1 = measureExecutionTime(for: day4_part1, label: "Part 1")
let result2 = measureExecutionTime(for: day4_part2, label: "Part 2")
