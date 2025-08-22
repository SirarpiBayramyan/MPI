import UIKit

// Implement a function makeShape()
// that returns some Shape and a function randomShape()
// that returns any Shape. Explain the difference in comments.

protocol Shape {
    var area: Double { get }
}

struct Circle: Shape {
    var radius: Double
    var area: Double { .pi * radius * radius }
}

struct Square: Shape {
    var side: Double
    var area: Double { side * side }
}

// Task: Implement `makeShape() -> some Shape`
// Task: Implement `randomShape() -> any Shape`


func makeShape() -> some Shape {
    Circle(radius: 1.0)
}

func randomShape() -> any Shape {
    if Bool.random() {
        return Circle(radius: 1.0)
    } else {
        return Square(side: 1.0)
    }
}

let shape = makeShape()
print(shape.area)


let shape2: any Shape = randomShape()
print(shape2.area)
