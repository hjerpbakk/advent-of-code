import Foundation

let loopExample = """
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
"""

func numberOfStepsToFarthestPoint() -> Int {
    //let loop = loopExample
    let graph = loop.components(separatedBy: "\n").map{ $0.map{ $0 } }
    
    
    var start: (j: Int, i: Int) = (-1, -1)
    for j in graph.indices {
        for i in graph[j].indices {
            if graph[j][i] == "S" {
                start = (j, i)
                break
            }
        }
        
        if start.j != -1 {
            break
        }
    }
    
    var found = false;
    var steps = 0
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: graph[0].count), count: graph.count)
    while (!found) {
        dfs(start.j, start.i)
    }
    
    return steps / 2
    
    func parseTile(_ tile: Character) -> [(y: Int, x: Int)] {
        switch tile {
        case "|":
            return [(-1, 0), (1, 0)]
        case "-":
            return  [(0, 1), (0, -1)]
        case "L":
            return  [(-1, 0), (0, 1)]
        case "J":
            return  [(-1, 0), (0, -1)]
        case "7":
            return [(1, 0), (0, -1)]
        case "F":
            return [(1, 0), (0, 1)]
        default:
            return [(0, 0), (0, 0)]
        }
    }
    
    func dfs(_ j: Int, _ i: Int) {
        if graph[j][i] == "." {
            return
        }
        
        if visited[j][i] {
            if graph[j][i] == "S" {
                // TODO: Tell her Ferdig
                found = true
            }
            
            return
        }
        /*
        | is a vertical pipe connecting north and south.
        - is a horizontal pipe connecting east and west.
        L is a 90-degree bend connecting north and east.
        J is a 90-degree bend connecting north and west.
        7 is a 90-degree bend connecting south and west.
        F is a 90-degree bend connecting south and east.
        */
        visited[j][i] = true
        steps += 1
        
        
        print("\(i), \(j)")
        for k in visited.indices {
            for l in visited[k].indices {
                if visited[k][l] {
                    print(graph[k][l], terminator: "")
                } else {
                    print(".", terminator: "")
                }
            }
                        
            print()
        }
        
        print()
        
        
        // TODO: Unødige utregninger
        let up = j - 1
        let down = j + 1
        let left = i - 1
        let right = i + 1
        if up >= 0 && !visited[up][i] && (graph[up][i] == "|" || graph[up][i] == "7" || graph[up][i] == "F") {
            return dfs(up, i)
        } else if down < visited.count && !visited[down][i] && (graph[down][i] == "|" || graph[down][i] == "L" || graph[down][i] == "J") {
            return dfs(down, i)
        } else if left >= 0 && !visited[j][left] && (graph[j][left] == "-" || graph[j][left] == "L" || graph[j][left] == "F") {
            return dfs(j, left)
        } else if right < visited[j].count && !visited[j][right] && (graph[j][right] == "-" || graph[j][right] == "J" || graph[j][right] == "7") {
            return dfs(j, right)
        }
    }
}
