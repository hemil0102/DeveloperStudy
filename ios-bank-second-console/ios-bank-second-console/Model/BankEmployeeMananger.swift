import Foundation

final class BankEmployeeManager {
    private let bankEmployee = BankEmployee()
    private var totalDurationOfTask = 0
    private var handledCustomer = 0
    
    func handleCustomersTask(with CustomerQueue: Queue<Customer>) {
        for _ in 1 ... CustomerQueue.totalLength() {
            if let customer = CustomerQueue.dequeue() {
                bankEmployee.callCustomer(with: customer)
                bankEmployee.handleCustomerTask(with: customer)
                handledCustomer = handledCustomer + 1
                totalDurationOfTask = totalDurationOfTask + bankEmployee.reportHandleTime()
            }
        }
    }
    
    func reportTotalDurationOfTask() -> Double {
        let roundedDuration = Double(totalDurationOfTask * 100) / 10000
        return roundedDuration
    }
    
    func reportHandledTask() -> Int {
        return handledCustomer
    }
    
    func resetHistory() {
        totalDurationOfTask = 0
        handledCustomer = 0
    }
}

