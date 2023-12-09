import Foundation

let historyExample = """
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
"""

func sumOfExtrapolatedValues() -> Int {
    let history = historyExample
    let histories = history.components(separatedBy: "\n")
        .map { $0.components(separatedBy: " ").map{ Int($0)! } }
    
    var extrapolatedValues: [Int] = []
    for history in histories {
        var input = history
        var differencesList: [[Int]] = [input]
        while true {
            var differences: [Int] = []
            for i in input.indices.dropFirst() {
                let difference = input[i] - input[i-1]
                differences.append(difference)
            }
            
            differencesList.append(differences)
            if differences.allSatisfy({ $0 == 0 }) {
                var extrapolatedValue = 0
                for j in differencesList.indices.dropFirst().reversed() {
                    extrapolatedValue = differencesList[j - 1].last! + differencesList[j].last!
                    differencesList[j - 1].append(extrapolatedValue)
                }
                
                extrapolatedValues.append(extrapolatedValue)
                break
            } else {
                input = differences
            }
        }
        
    }
    
    return extrapolatedValues.reduce(0, +)
}

func sumOfExtrapolatedValues2() -> Int {
    //let history = historyExample
    let histories = history.components(separatedBy: "\n")
        .map { $0.components(separatedBy: " ").map{ Int($0)! } }
    
    var extrapolatedValues: [Int] = []
    for history in histories {
        var input = history
        var differencesList: [[Int]] = [input]
        while true {
            var differences: [Int] = []
            for i in input.indices.dropFirst() {
                let difference = input[i] - input[i-1]
                differences.append(difference)
            }
            
            differencesList.append(differences)
            if differences.allSatisfy({ $0 == 0 }) {
                var extrapolatedValue = 0
                for j in differencesList.indices.dropFirst().reversed() {
                    extrapolatedValue = differencesList[j - 1].first! - differencesList[j].first!
                    differencesList[j - 1].insert(extrapolatedValue, at: 0)
                }
                
                extrapolatedValues.append(extrapolatedValue)
                break
            } else {
                input = differences
            }
        }
        
    }
    
    return extrapolatedValues.reduce(0, +)
}
