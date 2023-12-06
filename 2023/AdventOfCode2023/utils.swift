func firstAndLastNumber(_ string: String) -> (first: Character, last: Character) {
    var firstNumber: Character = "-"
    var lastNumber: Character = "-"

    for character in string {
        if character.isNumber {
            if (firstNumber == "-") {
                firstNumber = character
            } else {
                lastNumber = character
            }
        }
    }
    
    if (lastNumber == "-") {
        lastNumber = firstNumber
    }

    return (first: firstNumber, last: lastNumber)
}

/*func rewriteNumberStringsAsNumber(_ string: String) -> String {
    let stringNumbers = [("one", 1), ("two", 2), ("three", 3), ("four", 4), ("five", 5), ("six", 6), ("seven", 7), ("eight", 8), ("nine", 9)]
    var newString = string
    var positionsInString: [(String.Index, (String, Int))] = []
    
    for stringNumber in stringNumbers {
        var startIndex = string.startIndex
        while startIndex < string.endIndex,
            //  let range = string.range(of: stringNumber.0, range: startIndex..<string.endIndex) {
            //positionsInString.append((range.lowerBound, stringNumber))
            startIndex = range.upperBound
        }
    }
    
    positionsInString.sort(by: { $0.0 < $1.0 })
        
    var i = 0
    for positionInString in positionsInString {
        newString.insert(contentsOf: String(positionInString.1.1), at: newString.index(positionInString.0, offsetBy: i))
        i += 1
    }

    return newString
}*/
