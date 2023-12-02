func sumOfGameIds() -> Int {
    var sumOfGameIds = 0
    let limits = [12, 13, 14]
    let lines = games.split(separator: "\n")
    for line in lines {
        var withinLimits = true
        let game = line.split(separator: ": ")
        let rounds = game[1].split(separator: "; ")
        for round in rounds {
            let cubes = round.split(separator: ", ")
            for cube in cubes {
                let valueAndColor = cube.split(separator: " ")
                switch valueAndColor[1] {
                    case "red":
                        if Int(valueAndColor[0])! > limits[0] {
                            withinLimits = false
                            break;
                        }
                    case "green":
                        if Int(valueAndColor[0])! > limits[1] {
                            withinLimits = false
                            break;
                        }
                    case "blue":
                        if Int(valueAndColor[0])! > limits[2] {
                            withinLimits = false
                            break;
                        }
                    default:
                        break;
                }
            }
            
            if (!withinLimits) {
                break;
            }
        }
        
        if (withinLimits) {
            sumOfGameIds = sumOfGameIds + Int(game[0].split(separator: " ")[1])!
        }
    }
    
    return sumOfGameIds
}

func sumOfGameIdsImproved() -> Int {
    let colorLimits: [String: Int] = ["red": 12, "green": 13, "blue": 14]
    return games.split(separator: "\n").compactMap { line -> Int? in
        let parts = line.split(separator: ": ")
        let rounds = parts[1].split(separator: "; ")
        for round in rounds {
            let cubes = round.split(separator: ", ")
            for cube in cubes {
                let valueAndColor = cube.split(separator: " ")
                if let value = Int(valueAndColor[0]),
                    let limit = colorLimits[String(valueAndColor[1])],
                    value > limit {
                    return nil
                }
            }
        }
        return Int(parts[0].split(separator: " ")[1])
    }.reduce(0, +)
}

func sumOfPowerOfGames() -> Int {
    var sumOfGamePowers = 0
    let lines = games.split(separator: "\n")
    for line in lines {
        var highestValues = [0, 0, 0]
        let game = line.split(separator: ": ")
        let rounds = game[1].split(separator: "; ")
        for round in rounds {
            let cubes = round.split(separator: ", ")
            for cube in cubes {
                let valueAndColor = cube.split(separator: " ")
                switch valueAndColor[1] {
                case "red":
                    if Int(valueAndColor[0])! > highestValues[0] {
                        highestValues[0] = Int(valueAndColor[0])!
                    }
                case "green":
                    if Int(valueAndColor[0])! > highestValues[1] {
                        highestValues[1] = Int(valueAndColor[0])!
                    }
                case "blue":
                    if Int(valueAndColor[0])! > highestValues[2] {
                        highestValues[2] = Int(valueAndColor[0])!
                    }
                default:
                    break;
                }
            }
            
        }
        
        let power = highestValues.reduce(1, *)
        sumOfGamePowers = sumOfGamePowers + power
    }
    
    return sumOfGamePowers
}

func sumOfPowerOfGamesImproved() -> Int {
    return games.split(separator: "\n").map { line -> Int in
        let game = line.split(separator: ": ")
        let rounds = game[1].split(separator: "; ")
        var highestValues: [String: Int] = ["red": 0, "green": 0, "blue": 0]
        for round in rounds {
            round.split(separator: ", ").forEach { cube in
                let valueAndColor = cube.split(separator: " ")
                let color = String(valueAndColor[1])
                if let value = Int(valueAndColor[0]),
                    value > highestValues[color, default: 0] {
                    highestValues[color] = value
                }
            }
        }
        return highestValues.values.reduce(1, *)
    }.reduce(0, +)
}

