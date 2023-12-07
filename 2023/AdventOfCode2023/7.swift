let handsExample = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
"""

enum Kind: Int {
    case FiveOfAKind = 6
    case FourOfAKind = 5
    case FullHouse = 4
    case ThreeOfAKind = 3
    case TwoPair = 2
    case OnePair = 1
    case HighCard = 0
}

func totalWinnings() -> Int {
    let handsInput = handsExample
    let handsAndBid = handsInput.split(separator: "\n").map{ $0.split(separator: " ") }
    var hands: [(hand: String, strength: Int, bid:Int)] = []
    for handAndBid in handsAndBid {
        let hand = String(handAndBid[0])
        var strength = 0
        for n in (2...5).reversed() {
            let nOfAKind = hasNOfAKind(n, hand)
            if nOfAKind.found {
                switch n {
                    case 3:
                        if hasNOfAKind(2, hand, skip: nOfAKind.card).found {
                            strength = 4
                        } else {
                            strength = 3
                        }
                    case 2:
                        if hasNOfAKind(2, hand, skip: nOfAKind.card).found {
                            strength = 2
                        } else {
                            strength = 1
                        }
                    default:
                        strength = n + 1
                }
                
                break
            }
        }
        
        hands.append((hand, strength, Int(handAndBid[1])!))
    }
    
    let cardValues: [Character:Int] = ["A":14, "K":13, "Q":12, "J":11, "T":10, "9":9, "8":8, "7":7, "6":6, "5":5, "4":4, "3":3, "2":2]
    hands.sort {
        $0.strength == $1.strength ? compareSingleCards($0.hand, $1.hand, cardValues) : $0.strength > $1.strength
    }
    
    print(hands)
    var winnings = 0
    for i in hands.indices {
        winnings += hands[i].bid * (hands.count - i)
    }
    
    return winnings
}

private func hasNOfAKind(_ n: Int, _ hand: String, skip: Character = " ") -> (found: Bool, card: Character) {
    var cardCounts = [Character: Int]()
    for card in hand {
        if card == skip {
            continue
        }
        
        cardCounts[card, default: 0] += 1
    }
    
    if let foundCard = cardCounts.first(where: { $1 == n })?.key {
        return (true, foundCard)
    } else {
        return (false, " ")
    }
}

private func compareSingleCards(_ a: String, _ b: String, _ cardValues: [Character:Int]) -> Bool {
    for i in 0..<5 {
        let c = a.index(a.startIndex, offsetBy: i)
        let d = b.index(b.startIndex, offsetBy: i)
        let comparision = cardValues[a[c]]! - cardValues[b[d]]!
        if (comparision == 0) {
            continue
        }
        
        if (comparision > 0) {
            return true
        } else {
            return false
        }
    }
    
    return true
}

func totalWinningsJoker() -> Int {
    //let handsInput = handsExample
    let handsAndBid = handsInput.split(separator: "\n").map{ $0.split(separator: " ") }
    var hands: [(hand: String, strength: Int, bid:Int)] = []
    for handAndBid in handsAndBid {
        let hand = String(handAndBid[0])
        var strength = 0
        for n in (2...5).reversed() {
            let nOfAKind = hasNOfAKindJoker(n, hand)
            if nOfAKind.found {
                switch n {
                case 3:
                    if hasNOfAKindJoker(2, hand, skip: nOfAKind.card).found {
                        strength = 4
                    } else {
                        strength = 3
                    }
                case 2:
                    if hasNOfAKindJoker(2, hand, skip: nOfAKind.card).found {
                        strength = 2
                    } else {
                        strength = 1
                    }
                default:
                    strength = n + 1
                }
                
                break
            }
        }
        
        hands.append((hand, strength, Int(handAndBid[1])!))
    }
    
    let cardValuesJoker: [Character:Int] = ["A":14, "K":13, "Q":12, "J":1, "T":10, "9":9, "8":8, "7":7, "6":6, "5":5, "4":4, "3":3, "2":2]
    hands.sort {
        $0.strength == $1.strength ? compareSingleCards($0.hand, $1.hand, cardValuesJoker) : $0.strength > $1.strength
    }
    
    print(hands)
    var winnings = 0
    for i in hands.indices {
        winnings += hands[i].bid * (hands.count - i)
    }
    
    return winnings
}

private func hasNOfAKindJoker(_ n: Int, _ hand: String, skip: Character = " ") -> (found: Bool, card: Character) {
    let numberOfJokers = skip == " " ? hand.filter { $0 == "J" }.count : 0
    if (numberOfJokers == 5) {
        return (true, "J")
    }
    
    var cardCounts = [Character: Int]()
    for card in hand {
        if card == skip || card == "J" {
            continue
        }
        
        cardCounts[card, default: numberOfJokers] += 1
    }
    
    if let foundCard = cardCounts.first(where: { $1 == n })?.key {
        return (true, foundCard)
    } else {
        return (false, " ")
    }
}
