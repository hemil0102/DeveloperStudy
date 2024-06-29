import Foundation

struct BankEmployee {
    private var isTaskDone = false
    
    func callCustomer() {
        print("손님을 대기열에서 불러옵니다.")
    }
    
    func handleTask() {
        print("고객의 업무를 처리합니다.")
    }
}
