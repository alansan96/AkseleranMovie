import UIKit


class Node<T> {
    
    var data: T
    var leftNode: Node?
    var rightNode: Node?
    
    init(data: T,
         leftNode: Node? = nil,
         rightNode: Node? = nil) {
        self.data = data
        self.leftNode = leftNode
        self.rightNode = rightNode
    }

}


class BST<T: Comparable & CustomStringConvertible> {
    
    private var rootNode: Node<T>?
    
    func addNode(_ value: T) {
        let node = Node(data: value)
        if let rootNode = self.rootNode {
            self.insert(rootNode, node)
        } else {
            self.rootNode = node
        }
    }

    private func insert(_ root: Node<T>, _ node: Node<T>) {
        if root.data > node.data {
            if let leftNode = root.leftNode {
                self.insert(leftNode, node)
            } else {
                root.leftNode = node
            }
        } else {
            if let rightNode = root.rightNode {
                self.insert(rightNode, node)
            } else {
                root.rightNode = node
            }
        }
    }
    
    func printTree() {
        self.inorder(self.rootNode)
    }

    
    private func inorder(_ node: Node<T>?) {
        guard let _ = node else { return }
        self.inorder(node?.leftNode)
        print("\(node!.data)", terminator: " ")
        self.inorder(node?.rightNode)
    }
}

// MARK: - SEARCH
extension BST {
    
    func search(value: T) {
        self.search(self.rootNode, value)
    }
    
    private func search(_ root: Node<T>?, _ element: T) {
        
        guard let rootNode = root else {
            print("NODE is Not available : \(element)")
            return
        }
        
        print("current root node \(rootNode.data)")
        if element > rootNode.data {
            self.search(rootNode.rightNode, element)
        } else if element < rootNode.data {
            self.search(rootNode.leftNode, element)
        } else {
            print("NODE VALUE AVAILABLE : \(rootNode.data)")
        }
    }
}

// MARK: - DELETE
extension BST{
    
    func deleteKey(value: T)
    {
    rootNode = deleteRec(rootNode, value)
    }
    
    /* A recursive function to insert a new key in BST */
    func deleteRec(_ root: Node<T>?, _ key: T) -> Node<T>?
    {
    /* Base Case: If the tree is empty */
        if  root == nil{
        return root
        }
    
        if key < (root?.data)! {
        root?.leftNode = deleteRec(root?.leftNode, key)
        }
        else if key > (root?.data)!{
            root?.rightNode = deleteRec(root?.rightNode, key)
            }
    else
    {
        if root?.leftNode == nil{
            return root?.rightNode
        }
        else if root?.rightNode == nil{
            return root?.leftNode
        }
        
    root?.data = (minValue(root?.rightNode))!
    root?.rightNode = deleteRec(root?.rightNode, (root?.data)!)
    }
    
    return root
    }
    
    public func minValue(_ node: Node<T>?) -> T? {
        
        var tempNode = node
        
        while let next = tempNode?.leftNode {
            tempNode = next
        }
        return tempNode?.data
    }
    
}



let numberList : Array<Int> = [8, 2, 10, 9, 11, 1, 7]
var root = BST<Int>()
for number in numberList {
    root.addNode(number)
}
//should print sorted tree
root.deleteKey(value: 1)
root.printTree()
root.search(value: 9)
