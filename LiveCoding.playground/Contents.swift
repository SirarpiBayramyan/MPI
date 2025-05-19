import UIKit

func reverseWords(in input: String) -> String {
    if input.isEmpty {
        return input
    }
    let word = input.trimmingCharacters(in: .whitespaces)
    let array = word.components(separatedBy: .whitespaces)

    var reversed = array.reversed().joined(separator: " ")
    return reversed
}

reverseWords(in: " Hello world ")


func isPalindrome(_ s: String) -> Bool {
    if s.isEmpty {
        return true
    }

    let characters = Array(s)
    let count = characters.count
    for i in 0 ..< count/2 {
        if characters[i] != characters[count - i - 1] {
            return false
        }
    }

    return true

}


func findMissingNumber(_ nums: [Int]) -> Int {
    let n = nums.count
    let expectedSum = n * (n + 1) / 2
    let actualSum = nums.reduce(0, +)
    return expectedSum - actualSum
}


func merge(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 1 else { return intervals }

    // Step 1: Sort by the start of each interval
    let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
    var merged: [[Int]] = [sortedIntervals[0]]

    // Step 2: Iterate and merge
    for i in 1..<sortedIntervals.count {
        let current = sortedIntervals[i]
        var lastMerged = merged.removeLast()

        if current[0] <= lastMerged[1] {
            // Overlapping intervals: merge them
            lastMerged[1] = max(lastMerged[1], current[1])
            merged.append(lastMerged)
        } else {
            // No overlap
            merged.append(lastMerged)
            merged.append(current)
        }
    }

    return merged
}


func hasDuplicate(_ arr: [Int]) -> Bool {
    return Set(arr).count != arr.count
}
