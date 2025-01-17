import Foundation

func calculateOriginalLength(from compressed: String) -> Int {
    var totalLength = 0
    var currentNumber = ""

    for char in compressed {
        if char.isLetter {
            // If a letter is encountered:
            // Add the accumulated number to the totalLength (if there is any)
            if let count = Int(currentNumber) {
                totalLength += count - 1
            } else {
                // If there's no number, it means a single occurrence of the letter
                totalLength += 1
            }
            // Reset the current number accumulator
            currentNumber = ""
        } else if char.isNumber {
            // Accumulate the number (digits of a number might come consecutively)
            currentNumber.append(char)
        }
    }

    // Handle the last number in the compressed string
    if let count = Int(currentNumber) {
        totalLength += count
    }

    return totalLength 
}

// Example Usage
let compressedString1 = "A15BA5"
let compressedString2 = "A4B3"
let compressedString3 = "C1D10E2"

print(calculateOriginalLength(from: compressedString1)) // Output: 21
print(calculateOriginalLength(from: compressedString2)) // Output: 7
print(calculateOriginalLength(from: compressedString3)) // Output: 13

