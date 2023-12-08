import Foundation

let mapInstructionsExample = """
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
"""

let mapInstructionsEndInZExample = """
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
"""

func numberOfSteps() -> Int {
    //let mapInstructions = mapInstructionsExample
    let instructionsAndMap = mapInstructions.split(separator: "\n\n")
    let instructions: [Int] = instructionsAndMap[0].map { $0 == "L" ? 0 : 1 }
    
    var map: [String: [String]] = [:]
    let rows = instructionsAndMap[1].split(separator: "\n")
    for row in rows {
        let parts = row.components(separatedBy: " = (")
        let firstPart = parts[0]
        let secondPart = parts[1].trimmingCharacters(in: CharacterSet(charactersIn: "()"))
        let otherParts = secondPart.components(separatedBy: ", ")
        map[firstPart] = [otherParts[0], otherParts[1]]
    }
    
    var steps = 0
    var node = map["AAA"]!
    while true {
        for instruction in instructions {
            steps += 1
            let nextNode = node[instruction]
            if nextNode == "ZZZ" {
                return steps
            }
            
            node = map[nextNode]!
        }
    }
}

func numberOfStepsNodesEndingInZ() -> Int {
    //let mapInstructions = mapInstructionsEndInZExample
    let instructionsAndMap = mapInstructions.split(separator: "\n\n")
    let instructions: [Int] = instructionsAndMap[0].map { $0 == "L" ? 0 : 1 }
    
    var map: [String: [String]] = [:]
    var nodesEndingInA: [String] = []
    let rows = instructionsAndMap[1].split(separator: "\n")
    for row in rows {
        let parts = row.components(separatedBy: " = (")
        let firstPart = parts[0]
        if firstPart.last == "A" {
            nodesEndingInA.append(firstPart)
        }
        
        let secondPart = parts[1].trimmingCharacters(in: CharacterSet(charactersIn: "()"))
        let otherParts = secondPart.components(separatedBy: ", ")
        map[firstPart] = [otherParts[0], otherParts[1]]
    }
    
    var nodes = nodesEndingInA.map { map[$0]! }
    var stepsList: [Int] = []
    for i in nodes.indices {
        var steps = 0
        while true {
            var endsWithZ = false
            for instruction in instructions {
                steps += 1
                
                let nextNode = nodes[i][instruction]
                if nextNode.last == "Z" {
                    stepsList.append(steps)
                    endsWithZ = true
                } else {
                    nodes[i] = map[nextNode]!
                }
            }
            
            if endsWithZ {
                break
            }
        }
    }
    
    var result = 1
    for steps in stepsList {
        result = lcm(result, steps)
    }
    
    return result
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        return b == 0 ? a : gcd(b, a % b)
    }
    
    func lcm(_ a: Int, _ b: Int) -> Int {
        return a / gcd(a, b) * b
    }
}
