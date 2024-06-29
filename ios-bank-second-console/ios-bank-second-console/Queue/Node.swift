final class Node<T: Equatable> {
    private(set) var data: T?
    private(set) var next: Node<T>?
    
    init(data: T? = nil, next: Node<T>? = nil) {
        self.data = data
        self.next = next
    }
    
    func data(with data: T?) {
         self.data = data
    }
    
    func next(with next: Node<T>?) {
         self.next = next
    }
}
