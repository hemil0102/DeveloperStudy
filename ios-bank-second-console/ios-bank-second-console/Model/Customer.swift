import Foundation

struct Customer {
    private var isTaskDone = false
    
    func joinQueue() {
        print("손님이 대기열에 들어섭니다.")
    }
}
