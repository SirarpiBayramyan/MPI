import Foundation

protocol Container {

    associatedtype Item
    mutating func add(_ item: Item)
    var count: Int { get }
    subscript(index: Int) -> Item { get }
}

// Task1: Implement a generic Stack<T> that conforms to Container
// Task2: Implement a function allItemsMatch<C1: Container, C2: Container>(_ c1: C1, _ c2: C2) -> Bool
//       that returns true if all items are equal (requires Item: Equatable)

struct Stack<T>: Container {

    private var items: [T] = []
    
    mutating func add(_ item: T) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }

    subscript(index: Int) -> T {
        items[index]
    }


}

// task2
func allItemsMatch<C1: Container, C2: Container>(_ c1: C1, _ c2: C2) -> Bool
where C1.Item: Equatable, C1.Item == C2.Item {

        // Early exit if counts differ
        guard c1.count == c2.count else { return false }

        // Compare each item
        for i in 0..<c1.count {
            if c1[i] != c2[i] {
                return false
            }
        }

    return true
}

var stack1 = Stack<Int>()
stack1.add(1)
stack1.add(2)
stack1.add(3)

var stack2 = Stack<Int>()
stack2.add(1)
stack2.add(2)
stack2.add(3)

print(allItemsMatch(stack1, stack2)) // true

stack2.add(4)
print(allItemsMatch(stack1, stack2)) // false
