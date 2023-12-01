func sumOfCalibrationValues() -> Int {
    let lines = calibrationDocument.split(separator: "\n")
    var sum = 0
    for line in lines {
        let values = firstAndLastNumber(String(line))
        let calibrationValues = "\(values.first)\(values.last)"
        sum += Int(calibrationValues)!
    }
    
    return sum
}

func sumOfCalibrationValues2() -> Int {
    let lines = calibrationDocument.split(separator: "\n")
    var sum = 0
    for line in lines {
        let fixedLine = rewriteNumberStringsAsNumber(String(line))
        let values = firstAndLastNumber(String(fixedLine))
        let calibrationValues = "\(values.first)\(values.last)"
        sum += Int(calibrationValues)!
    }
    
    return sum
}
