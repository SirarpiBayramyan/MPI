func verify(s: String) -> Int {
    var stack = [Character]()

    for char in s {
        switch char {
        case "(", "[", "<":
            stack.append(char)
        case ")":
            if stack.popLast() != "(" { return 0 }
        case "]":
            if stack.popLast() != "[" { return 0 }
        case ">":
            if stack.popLast() != "<" { return 0 }
        default:
            continue
        }
    }

    return stack.isEmpty ? 1 : 0
}
print(verify(s: "---(++++)----")) // 1
print(verify(s: "")) // 1
print(verify(s: "before ( middle []) after ")) // 1
print(verify(s: ") (")) // 0
print(verify(s: "<(   >)")) // 0
print(verify(s: "(  [  <>  ()  ]  <>  )")) // 1
print(verify(s: "   (      [)")) // 0

import Foundation

// This function returns the last index of either a or b in the string s, or -1 if:
func challenge(s: String, a: String, b: String) -> Int {
    guard !s.isEmpty else { return -1 }
    let aIndex = s.lastIndex(of: Character(a))?.utf16Offset(in: s) ?? -1
    let bIndex = s.lastIndex(of: Character(b))?.utf16Offset(in: s) ?? -1
    if aIndex == -1 && bIndex == -1 { return -1 }
    if aIndex == -1 { return bIndex }
    if bIndex == -1 { return aIndex }
    return max(aIndex, bIndex)
}
