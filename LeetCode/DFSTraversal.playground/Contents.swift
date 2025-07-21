import Foundation

// Binary tree Node class
class Tree {

    var data: Int
    var left: Tree?
    var right: Tree?

    init(data: Int) {
        self.data = data
    }

}

// The functions that do the depth-first traversals.
func inOrder(node: Tree?) {
    guard let node = node else { return }
    inOrder(node: node.left)
    print(node.data)
    inOrder(node: node.right)
}

func preOrder(node: Tree?) {
    guard let node = node else { return }
    print(node.data)
    preOrder(node: node.left)
    preOrder(node: node.right)
}

func postOrder(node: Tree?) {
    guard let node = node else { return }
    postOrder(node: node.left)
    postOrder(node: node.right)
    print(node.data)
}

var root = Tree(data: 20)
root.left = Tree(data: 10)
root.left?.left = Tree(data: 5)
root.left?.right = Tree(data: 15)
root.right = Tree(data: 30)
root.right?.left = Tree(data: 25)
print("Preorder traversal of binary tree is")
preOrder(node: root)
print("Inorder traversal of binary tree is")
inOrder(node: root)
print("Postorder traversal of binary tree is")
postOrder(node: root)

