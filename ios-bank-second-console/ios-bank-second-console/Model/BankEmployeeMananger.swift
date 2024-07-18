import Foundation

final class BankEmployeeManager {
    private let bankEmployeeDepositEast = BankEmployee(jobPositon: .deposit, emozy: "💛")
    private let bankEmployeeDepositWest = BankEmployee(jobPositon: .deposit, emozy: "💚")
    private let bankEmployeeLoan = BankEmployee(jobPositon: .loan, emozy: "🟦")
    private let depositSemaphore = DispatchSemaphore(value: 1)
    private let loanSemaphore = DispatchSemaphore(value: 1)
    
    private var totalDurationOfTask = 0
    private var totalhandledCustomer = 0
    
    private let depositQueueEast = DispatchQueue(label: "depositQueueEast") // 커스컴큐, 기본 Serial 동작
    private let depositQueueWest = DispatchQueue(label: "depositQueueWest") // 커스컴큐, 기본 Serial 동작
    private let loanQueue = DispatchQueue(label: "loanQueue") // 커스컴큐, 기본 Serial 동작
    
    // 손님을 하나의 태스크로 산정하기
    func handleCustomersTask(with customerQueue: Queue<Customer>, by bankDispatchGroup: DispatchGroup) {
        
        while let customer = customerQueue.dequeue() {
            
                bankDispatchGroup.enter()
                loanQueue.async(group: bankDispatchGroup) {
                    if customer.readTask() == .loan {
                        self.bankEmployeeLoan.callCustomer(with: customer)
                        self.bankEmployeeLoan.handleCustomerTask(with: customer)
                    }
                    bankDispatchGroup.leave()
                }
            
                bankDispatchGroup.enter()
                depositQueueEast.async(group: bankDispatchGroup) {
                    if customer.readTask() == .deposit {
                        self.bankEmployeeDepositEast.callCustomer(with: customer)
                        self.bankEmployeeDepositEast.handleCustomerTask(with: customer)
                    }
                    bankDispatchGroup.leave()
                }
                
                bankDispatchGroup.enter()
                depositQueueWest.async(group: bankDispatchGroup) {
                    if customer.readTask() == .deposit {                        self.bankEmployeeDepositWest.callCustomer(with: customer)
                        self.bankEmployeeDepositWest.handleCustomerTask(with: customer)
                    }
                bankDispatchGroup.leave()
            }
        }
    }
    
    func reportTotalDurationOfTask() -> Double {
        let roundedDuration = Double(totalDurationOfTask * 100) / 10000
        return roundedDuration
    }
    
    func reportHandledTask() -> Int {
        return totalhandledCustomer
    }
    
    func resetHistory() {
        totalDurationOfTask = 0
        totalhandledCustomer = 0
    }
}

