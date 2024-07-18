import Foundation

struct BankEmployee {
    private var jobPositon: CustomerTask
    private var taskDuration: BankTaskDuration
    var emozy: String
    
    init(jobPositon: CustomerTask, emozy: String) {
        self.jobPositon = jobPositon
        self.taskDuration = jobPositon == .deposit ? BankTaskDuration.deposit: BankTaskDuration.loan
        self.emozy = emozy
    }
    
    func callCustomer(with customer: Customer) {
        print("\(customer.readTicketNumber())번 고객 \(customer.readTask().rawValue) 업무 시작, 은행원 \(emozy)")
    }
    
    func handleCustomerTask(with customer: Customer) {
        Thread.sleep(forTimeInterval: jobPositon == .deposit ?
                     Double(BankTaskDuration.deposit.rawValue)/100 :
                     Double(BankTaskDuration.loan.rawValue)/100 )
        print("\(customer.readTicketNumber())번 고객 \(customer.readTask().rawValue) 업무 종료, 은행원 \(emozy)")
    }
    
    func reportHandleTime() -> Int {
        return taskDuration.rawValue
    }
}
