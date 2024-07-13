import Foundation

struct BankMananger {
    private var isOpen: Bool = false
    private var customerManager = CustomerManager()
    private var bankEmployeeManager = BankEmployeeManager()
    
    // 서비스를 시작하는 부분
    mutating func startService() {
        printBankMenu()
        handleUserSelection()
    }
    
    // 손님 입력에 따라서 업무를 처리
    mutating func handleUserSelection() {
        repeat {
            let userInputResult = getUserInput()
            
            switch userInputResult {
            case .success(let avalilableInput):
                isOpen = (avalilableInput == .open)
                if isOpen {
                    handleCustomerTask()
                    reportBankingServiceHistory()
                }
            case .failure(let error):
                print(error.localizedDescription)
                isOpen = true
            }
            
            operateBankService()
            
        } while isOpen
    }
    
    // 손님의 업무를 처리
    func handleCustomerTask() {
        customerManager.generateCustomers()
        customerManager.enQueueCustomers()
        customerManager.checkCustomers()
        bankEmployeeManager.handleCustomersTask(with: customerManager.queue())
    }
    
    // 마감 보고
    func reportBankingServiceHistory() {
        let totalHandledCustomer = bankEmployeeManager.reportHandledTask()
        let totalTasksDuration = String(format: "%.2f", bankEmployeeManager.reportTotalDurationOfTask())
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalHandledCustomer)명이며, 총 업무 시간은 \(totalTasksDuration)초입니다.")
        bankEmployeeManager.resetHistory()
    }
    
    mutating func operateBankService() {
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
     
    // 유지 입력
    func getUserInput() -> Result<BankMenu, InputError> {
        guard let userConsoleInput = readLine(), let avalilableInput = BankMenu(rawValue: userConsoleInput) else {
            return .failure(.wrongInput)
        }
        
        return .success(avalilableInput)
    }
}
