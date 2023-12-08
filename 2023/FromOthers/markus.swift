import Foundation

func numberOfStepsNodesEndingInZMarkus() -> Int {
    let lines = mapInstructions.components(separatedBy: .newlines)
    let directions = Array(lines[0])
    
    struct Direction {
        let L: String
        let R: String
    }
    
    var directionMap: [String: Direction] = [:]
    
    for line in lines.dropFirst(2) where !line.isEmpty {
        let components = line.split(separator: "=").map { $0.trimmingCharacters(in: .whitespaces) }
        let key = String(components[0])
        let values = components[1].split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
        directionMap[key] = Direction(L: String(values[0].dropFirst()), R: String(values[1].dropLast()))
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        return b == 0 ? a : gcd(b, a % b)
    }
    
    func lcm(_ a: Int, _ b: Int) -> Int {
        return a / gcd(a, b) * b
    }
    
    let keys = directionMap.keys.filter { $0.hasSuffix("A") }
    
    let loopsNeeded = keys.map { key -> Int in
        var newKey = key
        var numberOfLoops = 0
        while !newKey.hasSuffix("Z") {
            let direction = directions[numberOfLoops % directions.count]
            newKey = direction == "L" ? directionMap[newKey]!.L : directionMap[newKey]!.R
            numberOfLoops += 1
        }
        return numberOfLoops
    }
    
    let result = loopsNeeded.reduce(1, lcm)

    return result
}


