import Foundation

struct Customer: Equatable {
    private var ticketNumber = 0
    
    init(ticketNumber: Int = 0) {
        self.ticketNumber = ticketNumber
    }
    
    func readTicketNumber() -> Int {
        return ticketNumber
    }
}
