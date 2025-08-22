// Identify and fix a retain cycle in the following code:

class Person {

    let name: String
    weak var pet: Pet? // Added Weak, or unowned
    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) deallocated")
    }

}

class Pet {

    let name: String
    var owner: Person? // Weak could be added here too
    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) deallocated")
    }

}

// Code that creates a retain cycle
var alice: Person? = Person(name: "Alice")
var buddy: Pet? = Pet(name: "Buddy")
alice?.pet = buddy
buddy?.owner = alice
alice = nil
buddy = nil

