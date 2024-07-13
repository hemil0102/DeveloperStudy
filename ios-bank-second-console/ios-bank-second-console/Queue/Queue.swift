final class Queue<T: Equatable> {
    private var linkedList: LinkedList<T> = LinkedList()
    var isEmpty: Bool { linkedList.isEmpty }
    
    func enqueue(with item: T) {
        linkedList.addNodeAtRear(with: item)
    }

    func dequeue() -> T? {
        return linkedList.deleteNodeFromFront()
    }
    
    func clean() {
        linkedList.clean()
    }

    func peek() -> T? {
        return linkedList.readFirstNodeData()
    }
    
    func totalLength() -> Int {
        return linkedList.count
    }
}
