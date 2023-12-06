let recordsExample = """
Time:      7  15   30
Distance:  9  40  200
"""

func marginOfError() -> Int {
    let records = recordsExample
    let initialSpeed = 0
    let acceleration = 1
    var waysToBeatTheRecords: [Int] = []
    
    let rows = records.split(separator: "\n")
    let times = rows[0].split(separator: ":")[1].split(separator: " ")
    let distances = rows[1].split(separator: ":")[1].split(separator: " ")
    var races: [(time: Int, distance: Int)] = []
    for i in times.indices {
        races.append((time: Int(times[i])!, distance: Int(distances[i])!))
    }
    
    for j in races.indices {
        var speed = initialSpeed
        for i in 1...races[j].time-1 {
            speed = speed + acceleration
            let distance = speed * (races[j].time - i)
            if distance > races[j].distance {
                if waysToBeatTheRecords.count <= j {
                    waysToBeatTheRecords.append(1)
                } else {
                    waysToBeatTheRecords[j] = waysToBeatTheRecords[j] + 1
                }
            }
        }
    }

    return waysToBeatTheRecords.reduce(1, *)
}

func marginOfErrorLong() -> Int {
    //let records = recordsExample
    let initialSpeed = 0
    let acceleration = 1
    var waysToBeatTheRecord = 0
    
    let rows = records.split(separator: "\n")
    let times = rows[0].split(separator: ":")[1].replacing(" ", with: "")
    let distances = rows[1].split(separator: ":")[1].replacing(" ", with: "")
    let time = Int(times)!
    let record = Int(distances)!
    
    var speed = initialSpeed
    for i in 1...time-1 {
        speed = speed + acceleration
        let distance = speed * (time - i)
        if distance > record {
            waysToBeatTheRecord = waysToBeatTheRecord + 1
        }
    }
    
    return waysToBeatTheRecord
}

