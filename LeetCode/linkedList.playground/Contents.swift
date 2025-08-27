import UIKit

import Foundation

// Node class
class Node<T> {
    var value: T
    var next: Node?

    init(value: T) {
        self.value = value
    }
}

// LinkedList class
class LinkedList<T> {
    private var head: Node<T>?

    // Check if list is empty
    var isEmpty: Bool {
        return head == nil
    }

    // Add element to the front
    func prepend(_ value: T) {
        let newNode = Node(value: value)
        newNode.next = head
        head = newNode
    }

    // Add element to the end
    func append(_ value: T) {
        let newNode = Node(value: value)
        guard let lastNode = getLastNode() else {
            head = newNode
            return
        }
        lastNode.next = newNode
    }

    // Get last node
    private func getLastNode() -> Node<T>? {
        var node = head
        while node?.next != nil {
            node = node?.next
        }
        return node
    }

    // Remove first node
    func removeFirst() -> T? {
        let value = head?.value
        head = head?.next
        return value
    }

    // Print all values
    func printList() {
        var node = head
        while let currentNode = node {
            print(currentNode.value)
            node = currentNode.next
        }
    }
}

