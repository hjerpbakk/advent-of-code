let scratchCardsExample = """
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
"""

func sumOfPointsOnCards() -> Int {
    //let scratchCards = scratchCardsExample
    let rows = scratchCards.split(separator: "\n")
    var games: [(winning: [Int], myCards: [Int])] = []
    for line in rows {
        let row = line.split(separator: ":")[1]
        let cardSplit = row.split(separator: "|")
        let winningCards = cardSplit[0].split(separator: " ").map { Int($0)! }
        let myCards = cardSplit[1].split(separator: " ").map { Int($0)! }
        games.append((winning: winningCards, myCards: myCards))
    }
    
    var points: [[Int]] = []
    for i in games.indices {
        points.append([])
        var j = 0
        for card in games[i].myCards {
            if games[i].winning.contains(card) {
                if (j == 0) {
                    points[i].append(1)
                } else {
                    points[i].append(points[i][j - 1] * 2)
                }
                
                j += 1
            }
        }
    }
    
    return points.compactMap{ $0.last }.reduce(0, +)
}

func totalScratchCards() -> Int {
    //let scratchCards = scratchCardsExample
    let rows = scratchCards.split(separator: "\n")
    var games: [(name: Int, winning: [Int], myCards: [Int])] = []
    for i in rows.indices {
        let row = rows[i].split(separator: ":")[1]
        let cardSplit = row.split(separator: "|")
        let winningCards = cardSplit[0].split(separator: " ").map { Int($0)! }
        let myCards = cardSplit[1].split(separator: " ").map { Int($0)! }
        games.append((name: i + 1, winning: winningCards, myCards: myCards))
    }
    
    let ogGames = games
    var i = 0
    var limit = games.count
    var cardsCache: [Int: [(name: Int, winning: [Int], myCards: [Int])]] = [:]
    while i < limit {
        let checkGame = ogGames[games[i].name - 1]
        if cardsCache[checkGame.name] == nil {
            let numberOfWinningCards = games[i].myCards.filter { checkGame.winning.contains($0) }.count
            var newCards: [(name: Int, winning: [Int], myCards: [Int])] = []
            if numberOfWinningCards > 0 {
                for j in 1...numberOfWinningCards {
                    let newCard = ogGames[games[i].name + j - 1]
                    newCards.append(newCard)
                }
            }
            
            cardsCache[checkGame.name] = newCards
        }
        
        for card in cardsCache[checkGame.name]! {
            games.append(card)
        }
        
        i += 1
        limit += cardsCache[checkGame.name]!.count
    }
    
    return games.count
}

