
let queue = Queue<Int>()

queue.enqueue(with: 1)
queue.enqueue(with: 2)
queue.enqueue(with: 3)

print(queue.totalLength())
print(queue.peek())
print(queue.dequeue())
print(queue.peek())
print(queue.totalLength())
print(queue.isEmpty)

queue.clean()

print(queue.isEmpty)
print(queue.peek())

