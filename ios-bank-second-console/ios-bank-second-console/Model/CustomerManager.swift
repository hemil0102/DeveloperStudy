import Foundation

final class CustomerManager {
    private var customerCount: Int = 0
    private let custumerQueue = Queue<Customer>()
    
    func generateCustomers() {
        self.customerCount = Int.random(in: 15...30)
        print("고객이 \(self.customerCount)명 생성되었어요.")
    }
    
    func enQueueCustomers() {
        for ticketNumber in 1...customerCount {
            custumerQueue.enqueue(with: Customer(ticketNumber: ticketNumber))
        }
    }

    func queue() -> Queue<Customer> {
        return custumerQueue
    }
    
    func checkCustomers() {
        print("고객 대기수는:" + "\(custumerQueue.totalLength())")
    }
}
