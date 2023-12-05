let almanacExample = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
"""

enum MapKind: CaseIterable {
    case seeds
    case seedToSoil
    case soilToFertilizer
    case fertilizerToWater
    case waterToLight
    case lightToTemperature
    case temperatureToHumidity
    case humidityToLocation
}

var maps: [MapKind: [[Int]]] = [:]

func lowestLocationNumber() -> Int {
    let rows = almanac.split(separator: "\n")
    var parse: MapKind = MapKind.seeds
    var seeds: [Int] = []
    for row in rows {
        if row.starts(with: "seeds:") {
            parse = .seeds
        } else if row == "seed-to-soil map:" {
            parse = .seedToSoil
            continue
        } else if row == "soil-to-fertilizer map:" {
            parse = .soilToFertilizer
            continue
        } else if row == "fertilizer-to-water map:" {
            parse = .fertilizerToWater
            continue
        } else if row == "water-to-light map:" {
            parse = .waterToLight
            continue
        } else if row == "light-to-temperature map:" {
            parse = .lightToTemperature
            continue
        } else if row == "temperature-to-humidity map:" {
            parse = .temperatureToHumidity
            continue
        } else if row == "humidity-to-location map:" {
            parse = .humidityToLocation
            continue
        }
        
        switch(parse) {
        case .seedToSoil, .soilToFertilizer, .fertilizerToWater, .waterToLight, .lightToTemperature, .temperatureToHumidity, .humidityToLocation:
            addMapping(row, kind: parse)
        case .seeds:
            seeds = row.split(separator: ":")[1].split(separator: " ").map{ Int($0)! }
        }
    }
    
    var locations: [Int] = []
    for seed in seeds {
        let destination = 0
        let source = 1
        let rangeLength = 2
        var id = seed
        for kind in MapKind.allCases.dropFirst() {
            print(kind)
            for map in maps[kind]! {
                if (id - map[source] >= map[rangeLength] || id < map[source]) {
                    continue
                }
                
                id = map[destination] + (id - map[source])
                break
            }
            print(id)
        }
        
        locations.append(id)
    }
    
    return locations.min()!
}

private func addMapping(_ source: Substring, kind: MapKind) {
    if maps[kind] == nil {
        maps[kind] = []
    }
    
    maps[kind]!.append(source.split(separator: " ").map{ Int($0)! })
}

func lowestLocationNumber2() -> Int {
    //let almanac = almanacExample
    let rows = almanac.split(separator: "\n")
    var parse: MapKind = MapKind.seeds
    var seedNumbers: [Int] = []
    for row in rows {
        if row.starts(with: "seeds:") {
            parse = .seeds
        } else if row == "seed-to-soil map:" {
            parse = .seedToSoil
            continue
        } else if row == "soil-to-fertilizer map:" {
            parse = .soilToFertilizer
            continue
        } else if row == "fertilizer-to-water map:" {
            parse = .fertilizerToWater
            continue
        } else if row == "water-to-light map:" {
            parse = .waterToLight
            continue
        } else if row == "light-to-temperature map:" {
            parse = .lightToTemperature
            continue
        } else if row == "temperature-to-humidity map:" {
            parse = .temperatureToHumidity
            continue
        } else if row == "humidity-to-location map:" {
            parse = .humidityToLocation
            continue
        }
        
        switch(parse) {
        case .seedToSoil, .soilToFertilizer, .fertilizerToWater, .waterToLight, .lightToTemperature, .temperatureToHumidity, .humidityToLocation:
            addMapping(row, kind: parse)
        case .seeds:
            seedNumbers = row.split(separator: ":")[1].split(separator: " ").map{ Int($0)! }
        }
    }
    
    let destination = 0
    let source = 1
    let rangeLength = 2
    var possibleLocation = 0
    let kinds = MapKind.allCases.reversed().dropLast()
    while true {
        var id = possibleLocation
        for kind in kinds {
            var found = false
            for map in maps[kind]! {
                if id - map[destination] >= 0 && map[destination] + map[rangeLength] >= id {
                    id = map[source] + (id - map[destination])
                    found = true
                    break
                } else {
                    continue
                }
            }
            
            if !found && kind != .humidityToLocation {
                break;
            }
        }
        
        for i in stride(from: 0, to: seedNumbers.count, by: 2) {
            if id >= seedNumbers[i] && id < seedNumbers[i] + seedNumbers[i + 1] - 1 {
                return possibleLocation
            }
        }
        
        possibleLocation += 1
    }
}
