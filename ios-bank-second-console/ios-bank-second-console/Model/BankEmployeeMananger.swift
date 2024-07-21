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
    private let totalQueue = DispatchQueue(label: "totlaQueue", attributes: .concurrent)
    
    // 손님을 하나의 태스크로 산정하기
    func handleCustomersTask(with customerQueue: Queue<Customer>, by bankDispatchGroup: DispatchGroup) {
        totalQueue.sync {
        while let customer = customerQueue.dequeue() {
            
                if customer.readTask() == .loan {
                    bankDispatchGroup.enter()
                    totalQueue.async(group: bankDispatchGroup) {
                        self.loanQueue.sync {
                            print("\(customer.readTicketNumber()), \(customer.readTask()), 시작")
                            Thread.sleep(forTimeInterval: 2)
                            print("\(customer.readTicketNumber()), \(customer.readTask()), 종료")
                        }
                        bankDispatchGroup.leave()
                    }
                } else {
                    totalQueue.async(group: bankDispatchGroup) {
                        bankDispatchGroup.enter()
                        self.depositQueueEast.async {
                            print("\(customer.readTicketNumber()), \(customer.readTask()), 시작")
                            Thread.sleep(forTimeInterval: 0.5)
                            print("\(customer.readTicketNumber()), \(customer.readTask()), 종료")
                        }
                        bankDispatchGroup.leave()
                        
                        bankDispatchGroup.enter()
                        self.depositQueueWest.async {
                            print("\(customer.readTicketNumber()), \(customer.readTask())")
                            Thread.sleep(forTimeInterval: 0.5)
                            print("\(customer.readTicketNumber()), \(customer.readTask()), 종료")
                        }
                        bankDispatchGroup.leave()
                    }
                }
            }
        }
    
        
//        while customerQueue.peek()?.readTask() == .loan {
//            if let customer = customerQueue.dequeue() {
//                bankDispatchGroup.enter()
//                loanQueue.async(group: bankDispatchGroup) {
//                        self.bankEmployeeLoan.callCustomer(with: customer)
//                        self.bankEmployeeLoan.handleCustomerTask(with: customer, by: bankDispatchGroup)
//                }
//            }
//        }

        
//        while let customer = customerQueue.dequeue() {
//            depositQueueEast.async(group: bankDispatchGroup) {
//                if customer.readTask() == .deposit {
//                    self.bankEmployeeDepositEast.callCustomer(with: customer)
//                    self.bankEmployeeDepositEast.handleCustomerTask(with: customer)
//                }
//            }
//        }
//        
//        while let customer = customerQueue.dequeue() {
//            depositQueueWest.async(group: bankDispatchGroup) {
//                if customer.readTask() == .deposit {
//                    self.bankEmployeeDepositWest.callCustomer(with: customer)
//                    self.bankEmployeeDepositWest.handleCustomerTask(with: customer)
//                }
//            }
//        }
        

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

