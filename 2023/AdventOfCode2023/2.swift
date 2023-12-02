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

