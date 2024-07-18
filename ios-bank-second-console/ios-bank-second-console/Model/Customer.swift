import Foundation

struct Customer: Equatable {
    private var ticketNumber = 0
    private var task: CustomerTask
    
    init(ticketNumber: Int = 0, customerTask: CustomerTask) {
        self.ticketNumber = ticketNumber
        self.task = customerTask
    }
    
    func readTicketNumber() -> Int {
        return ticketNumber
    }
    
    func readTask() -> CustomerTask {
        return task
    }
}
