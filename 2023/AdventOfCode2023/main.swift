import Foundation

let start = Date()

let result = numberOfStepsNodesEndingInZMarkus()

let end = Date()

let timeInterval = end.timeIntervalSince(start)
let milliseconds = timeInterval * 1000
let formattedTime = String(format: "%.3f", milliseconds)

print(result)
print()
print("Finished in \(formattedTime) ms")
