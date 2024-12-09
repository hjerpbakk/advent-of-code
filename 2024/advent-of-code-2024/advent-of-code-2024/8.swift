import Foundation

private let example8 = """
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
"""

private let input8 = """
.C...............w.......................M.E......
...............G........V.............Q....M......
u........k...........V.y..3........Q..........4.a.
..........c.9........k..................i..7..a...
..............y.......................o....a......
.......C...........6.......y.............E........
.............................5....x............i..
...............c.....wy..V.......5..............E.
........k.......c....G..I............o.........m..
............C....s......G......o..........5.......
......................Q...............5....e...4i.
.....I.....................................m.....j
....9K.T.....I...c......w...................X.....
................I.........w....f............3..e.N
C............9..........6..............7...3......
...Z........K.......T.................6...........
......Z..................6...............HN.E.m...
...K...........................1....N...e.o..X....
............hz......................7........j....
.........9......U.R......n.....4.Q..L...X.........
..................A...........S.......0...........
...............l.........p...........2.3M.......x.
.h........................U.................g.....
...Hld...........A..W.......................1x....
.....Z.....n.......lp...e............Xj...L.......
........hU................7...j...S...............
......n............U..........D....S..q...........
....H.....d.r..T..............0..........L.S......
......H......A..T...lp.........LK....1.....2.f.x..
....Z............................g....4...........
..d..r............V...............f..g....2.......
.rn.........D............Pp........q....g.........
..................................................
...................D...0.........Y..t...P.q.......
.......R.s.......................q.P..1...........
...........h..........................2.........f.
........................W.........................
...8...........O................k.................
....rY...........D................P...............
....................O...u.........................
..s..................F............................
...................R......F.......................
......8...........z0....F................J.W......
...................F..z................u..........
..............R.........O.............v.Jt........
s.............8.........m........J.t............v.
......Y.....M........................u..tv........
.................................................v
..................................................
.................z.W..................J...........
"""

func day8_part1() -> Int {
    let map = input8.split(separator: "\n").map { Array($0) }
    let rows = map.count
    let cols = map[0].count
    
    struct Position: Hashable {
        let r: Int
        let c: Int
    }
    
    var antennasByFreq = [Character: [Position]]()
    for r in 0..<rows {
        for c in 0..<cols {
            let ch = map[r][c]
            if ch != "." {
                antennasByFreq[ch, default: []].append(Position(r: r, c: c))
            }
        }
    }
    
    var antinodes = Set<Position>()
    
    for (_, positions) in antennasByFreq {
        let count = positions.count
        for i in 0..<count {
            for j in i+1..<count {
                let a = positions[i]
                let b = positions[j]
                
                // Antinode 1
                let c1 = Position(r: 2*a.r - b.r, c: 2*a.c - b.c)
                if c1.r >= 0 && c1.r < rows && c1.c >= 0 && c1.c < cols {
                    antinodes.insert(c1)
                }
                
                // Antinode 2
                let c2 = Position(r: 2*b.r - a.r, c: 2*b.c - a.c)
                if c2.r >= 0 && c2.r < rows && c2.c >= 0 && c2.c < cols {
                    antinodes.insert(c2)
                }
            }
        }
    }
    
    return antinodes.count
}

func day8_part2() -> Int {
    let map = input8.split(separator: "\n").map { Array($0) }
    let rows = map.count
    let cols = map[0].count
    
    struct Position: Hashable {
        let r: Int
        let c: Int
    }
    
    // Collect antennas by frequency
    var antennasByFreq = [Character: [Position]]()
    for r in 0..<rows {
        for c in 0..<cols {
            let ch = map[r][c]
            if ch != "." {
                antennasByFreq[ch, default: []].append(Position(r: r, c: c))
            }
        }
    }
    
    var antinodes = Set<Position>()
    
    // For each frequency, for each pair of antennas, find all integer points along the infinite line
    // that passes through them (within map bounds). All those points are antinodes.
    for (_, positions) in antennasByFreq {
        // If only one antenna, it can't form a line with another of the same frequency, so no antinodes
        // except that a single antenna isn't in line with another. So skip if count < 2.
        if positions.count < 2 {
            // No line formed, so just continue
            continue
        }
        
        // Actually, since any point that is exactly in line with at least two antennas
        // is an antinode, every antenna of this frequency is also an antinode
        // (because there's at least one other antenna on the line with it).
        // Add them all first:
        for a in positions {
            antinodes.insert(a)
        }
        
        let count = positions.count
        // To avoid processing the same line multiple times, we can use a set of lines.
        // A line can be represented by a normalized direction vector and a point.
        // But it may be enough just to iterate pairs:
               
        for i in 0..<count {
            for j in i+1..<count {
                let a = positions[i]
                let b = positions[j]
                let dr = b.r - a.r
                let dc = b.c - a.c
                let g = gcd(abs(dr), abs(dc))
                let drStep = dr / g
                let dcStep = dc / g
                
                // To uniquely represent a line, we can:
                // Lines passing through (a) and (b) have direction (drStep, dcStep).
                // A canonical representation could be the direction plus the smallest "offset".
                // But we only need to consider the lines for placing antinodes.
                // Since we already handle duplicates by adding to a set of positions,
                // we might not need to deduplicate lines. It's okay if we process a line multiple times.
                // For efficiency, let's just rely on the Set<Position> to avoid duplicates.
                
                // We want all integer points on the line defined by direction (drStep, dcStep) that pass through a (or b).
                // Any integer point on this line can be represented as:
                // (r, c) = (a.r + t*drStep, a.c + t*dcStep), for t in Z.
                // Find the range of t that keep us inside the map.
                
                // For row bounds:
                // 0 <= a.r + t*drStep <= rows-1
                // Similarly for columns:
                // 0 <= a.c + t*dcStep <= cols-1
                
                func boundsFor(value: Int, step: Int, maxVal: Int) -> (Double, Double)? {
                    // Solve 0 <= value + t*step <= maxVal
                    // If step == 0, then we must have 0 <= value <= maxVal to have any valid t, otherwise no solution.
                    if step == 0 {
                        if value >= 0 && value <= maxVal {
                            // any t works, so infinite range
                            return (-Double.infinity, Double.infinity)
                        } else {
                            return nil
                        }
                    } else {
                        let low = (Double(-value))/Double(step)
                        let high = (Double(maxVal - value))/Double(step)
                        // If step < 0, swap low/high
                        return step > 0 ? (low, high) : (high, low)
                    }
                }
                
                guard let rowRange = boundsFor(value: a.r, step: drStep, maxVal: rows-1),
                      let colRange = boundsFor(value: a.c, step: dcStep, maxVal: cols-1) else {
                    // no valid intersection with map
                    continue
                }
                
                // intersection of rowRange and colRange:
                let lowT = max(rowRange.0, colRange.0)
                let highT = min(rowRange.1, colRange.1)
                
                // We need integer t values in [lowT, highT]
                let startT = Int(ceil(lowT))
                let endT = Int(floor(highT))
                
                if startT <= endT {
                    for t in startT...endT {
                        let rr = a.r + t*drStep
                        let cc = a.c + t*dcStep
                        antinodes.insert(Position(r: rr, c: cc))
                    }
                }
            }
        }
    }
    
    return antinodes.count
}

func gcd(_ a: Int, _ b: Int) -> Int {
    var a = a, b = b
    while b != 0 {
        let t = a % b
        a = b
        b = t
    }
    return a
}
