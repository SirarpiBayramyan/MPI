import Foundation

class Owner {
    var name: String
    var pet: Pet?           // strong reference to Pet

    init(name: String) {
        self.name = name
        print("👤 Owner \(name) initialized")
    }

    deinit {
        print("💀 Owner \(name) deinitialized")
    }
}

class Pet {
    var name: String

    // MARK: - Reference Types
    weak var weakOwner: Owner?      // Does NOT retain Owner (optional)
    unowned var unownedOwner: Owner // Does NOT retain Owner (non-optional)

    init(name: String, weakOwner: Owner, unownedOwner: Owner) {
        self.name = name
        self.weakOwner = weakOwner
        self.unownedOwner = unownedOwner
        print("🐶 Pet \(name) initialized")
    }

    func printOwners() {
        print("🐶 \(name)'s weakOwner: \(weakOwner?.name ?? "nil")")
        print("🐶 \(name)'s unownedOwner: \(unownedOwner.name)")
    }

    deinit {
        print("💀 Pet \(name) deinitialized")
    }
}


func testReferences() {
    var owner: Owner? = Owner(name: "Alice")

    if let o = owner {
        let pet = Pet(name: "Buddy", weakOwner: o, unownedOwner: o)
        o.pet = pet
        pet.printOwners()
    }

    print("🔁 Setting owner to nil")
    owner = nil
}

// 👤 Owner Alice initialized
// 🐶 Pet Buddy initialized
// 🐶 Buddy's weakOwner: Alice
// 🐶 Buddy's unownedOwner: Alice
// 🔁 Setting owner to nil
// 💀 Owner Alice deinitialized
// 💀 Pet Buddy deinitialized
