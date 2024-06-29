final class Queue<T: Equatable> {
    private var linkedList: LinkedList<T> = LinkedList()
    var isEmpty: Bool { linkedList.isEmpty }
    
    func enqueue(with item: T) {
        linkedList.addNodeAtRear(with: item)
    }
    
    @discardableResult
    func dequeue() -> T? {
        return linkedList.deleteNodeFromFront()
    }
    
    func clean() {
        linkedList.clean()
    }
    
    @discardableResult
    func peek() -> T? {
        return linkedList.readFirstNodeData()
    }
    
    @discardableResult
    func totalLength() -> Int {
        return linkedList.count
    }
}
