let engineSchematicExample = """
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
"""

func sumOfPartNumbers() -> Int {
    let rows = engineSchematic.split(separator: "\n").map { Array("...\($0)...") }
    let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    var partNumbers: [Int] = []
    for j in rows.indices {
        var partialNumber = ""
        var indexOfFirstPartOfNumber: Int? = nil
        for i in rows[j].indices {
            if rows[j][i].isNumber {
                if (indexOfFirstPartOfNumber == nil) {
                    indexOfFirstPartOfNumber = i
                }
                
                partialNumber = "\(partialNumber)\(rows[j][i])"
            } else {
                if (indexOfFirstPartOfNumber == nil) {
                    continue;
                }
                
                var isAdjacentToSymbol = false
                for k in indexOfFirstPartOfNumber!...i-1 {
                    for direction in directions {
                        let checkPosition = (j + direction.0, k + direction.1)
                        if (checkPosition.0 < 0 || checkPosition.0 == rows.count) {
                            continue;
                        }
                        
                        let potentialSymbol = rows[checkPosition.0][checkPosition.1]
                        if (potentialSymbol == "." || potentialSymbol.isNumber) {
                            continue;
                        }
                        
                        isAdjacentToSymbol = true
                        break
                    }
                    
                    if isAdjacentToSymbol {
                        break;
                    }
                }
                
                if isAdjacentToSymbol {
                    partNumbers.append(Int(partialNumber)!)
                    print(partialNumber)
                } else {
                    print("not \(partialNumber)")
                }
                
                indexOfFirstPartOfNumber = nil
                partialNumber = ""
            }
        }
    }
    
    return partNumbers.reduce(0, +)
}

func sumOfGearRatios() -> Int {
    let rows = engineSchematic.split(separator: "\n").map { Array("...\($0)...") }
    let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    var gearRatios: [Int] = []
    var numbers: [[Int]] = []
    for j in rows.indices {
        var partialNumber = ""
        var indexOfFirstPartOfNumber: Int? = nil
        numbers.append([])
        for i in rows[j].indices {
            numbers[j].append(-1)
            if rows[j][i].isNumber {
                if (indexOfFirstPartOfNumber == nil) {
                    indexOfFirstPartOfNumber = i
                }
                
                partialNumber = "\(partialNumber)\(rows[j][i])"
            } else {
                if (indexOfFirstPartOfNumber == nil) {
                    continue;
                }
                
                let number = Int(partialNumber)!
                for k in indexOfFirstPartOfNumber!...i-1 {
                    numbers[j][k] = number
                }
                indexOfFirstPartOfNumber = nil
                partialNumber = ""
            }
        }
    }
    
    for j in rows.indices {
        for i in rows[j].indices {
            if rows[j][i] == "*" {
                var number1 = -1
                var number2 = -1
                for direction in directions {
                    let checkPosition = (j + direction.0, i + direction.1)
                    if (checkPosition.0 < 0 || checkPosition.0 == rows.count) {
                        continue;
                    }
                    
                    if numbers[checkPosition.0][checkPosition.1] != -1 {
                        if number1 == -1 {
                            number1 = numbers[checkPosition.0][checkPosition.1]
                        } else {
                            number2 = numbers[checkPosition.0][checkPosition.1]
                        }
                    }
                }
                
                if (number1 != -1 && number2 != -1 && number1 != number2) {
                    gearRatios.append(number1 * number2)
                }
            }
        }
    }
    
    return gearRatios.reduce(0, +)
}
