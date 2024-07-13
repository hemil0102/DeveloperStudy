final class LinkedList<T: Equatable> {
    private(set) var head: Node<T>?
    private(set) var tail: Node<T>?
    private(set) var count: Int = 0
    var isEmpty: Bool { head == nil }
    
    // 노드를 뒤에 추가하기
    func addNodeAtRear(with data: T) {
        let newNode = Node(data: data)
        
        if isEmpty {
            head = newNode
            tail = newNode
        } else {
            tail?.next(with: newNode)
            tail = newNode
        }
        count += 1
    }
    
    // 노드를 앞에서부터 삭제하기
    func deleteNodeFromFront() -> T? {
        guard let currentHead = head else { return nil }

        head = currentHead.next
        if head == nil { tail = nil }
        count -= 1
        
        return currentHead.data
    }
    
    // 모든 노드를 삭제하기
    func clean() {
        head = nil
        tail = nil
        count = 0
    }
    
    // 첫 번째 노드를 불러오기
    func readFirstNodeData() -> T? {
        head?.data
    }

    // 데이터가 같은 노드의 위치(순번) 찾기
    func searchNodeLocation(with data: T) -> Int? { // T?
        var current = head
        var locationIndex = 0
        
        while let currentNode = current {
            if currentNode.data == data {
                return locationIndex
            }
            current = currentNode.next
            locationIndex += 1
        }
    
        return nil
    }
}
