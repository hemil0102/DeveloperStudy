import Foundation

final class CustomerManager {
    private var customerCount: Int = 0
    private let custumerQueue = Queue<Customer>()
    
    func generateCustomers() {
        self.customerCount = Int.random(in: 5...10)
        print("고객이 \(self.customerCount)명 생성되었어요.")
    }
    
    func enQueueCustomers() {
        for ticketNumber in 1...customerCount {
            let generatedTask = generateCustomerTask()
            custumerQueue.enqueue(with: Customer(ticketNumber: ticketNumber, customerTask: generatedTask))
        }
    }
    
    func generateCustomerTask() -> CustomerTask {
        let randomValue = arc4random_uniform(2)
        return randomValue == 0 ? .deposit : .loan
    }

    func queue() -> Queue<Customer> {
        return custumerQueue
    }
    
    func checkCustomerCount() {
        print("고객 대기수는:" + "\(custumerQueue.totalLength())")
    }
}
