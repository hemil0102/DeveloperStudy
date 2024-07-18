import Foundation

class BankMananger {
    private var isOpen: Bool = false
    private var customerManager = CustomerManager()
    private var bankEmployeeManager = BankEmployeeManager()
    let bankDispatchGroup = DispatchGroup()
    
    // 서비스를 시작하는 부분
    func startService() {
        printBankMenu()
        handleUserSelection()
    }
    
    // 손님 입력에 따라서 업무를 처리
    func handleUserSelection() {
        repeat {
            let userInputResult = getUserInput()
            
            switch userInputResult {
            case .success(let avalilableInput):
                isOpen = (avalilableInput == .open)
                if isOpen {
                    handleCustomerTask(with: bankDispatchGroup)
                    bankDispatchGroup.notify(queue: .global()) { // ❓ 여기 .main 왜 안되지 다시 찾아볼 것!
                        self.reportBankingServiceHistory()
                        self.operateBankService()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                isOpen = true
                self.operateBankService()
            }
        } while isOpen
    }
    
    // 손님의 업무를 처리
    func handleCustomerTask(with bankDispatchGroup: DispatchGroup) {
        customerManager.generateCustomers()
        customerManager.enQueueCustomers()
        customerManager.checkCustomerCount()
        bankEmployeeManager.handleCustomersTask(with: customerManager.queue(), by: bankDispatchGroup)
    }
    
    // 마감 보고
    func reportBankingServiceHistory() {
        let totalHandledCustomer = bankEmployeeManager.reportHandledTask()
        let totalTasksDuration = String(format: "%.2f", bankEmployeeManager.reportTotalDurationOfTask())
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalHandledCustomer)명이며, 총 업무 시간은 \(totalTasksDuration)초입니다.")
        bankEmployeeManager.resetHistory()
    }
    
    // 은행 서비스 시작, 종료를 관리
    func operateBankService() {
        if isOpen {
            startService()
        } else {
            closeService()
        }
    }
    
    // 은행 종료
    func closeService() {
        print("은행 업무를 종료합니다!")
    }
    
    // 은행 메뉴 출력
    func printBankMenu() {
        print("1 : 은행 개점")
        print("2 : 종료")
        print("입력 : ", terminator: "")
    }
     
    // 유저 입력
    func getUserInput() -> Result<BankMenu, InputError> {
        guard let userConsoleInput = readLine(), let avalilableInput = BankMenu(rawValue: userConsoleInput) else {
            return .failure(.wrongInput)
        }
        
        return .success(avalilableInput)
    }
}
