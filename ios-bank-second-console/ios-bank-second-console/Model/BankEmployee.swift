import Foundation

struct BankEmployee {
    private var jobPositon = "deposit"
    private let taskDuration = 70
    
    func callCustomer(with customer: Customer) {
         print("\(customer.readTicketNumber())번 고객 업무 시작")
    }
    
    func handleCustomerTask(with customer: Customer) {
        print("\(customer.readTicketNumber())번 고객 업무 종료")
    }
    
    func reportHandleTime() -> Int {
        return taskDuration
    }
}
