import Foundation

final class AssignmentViewModel {
    
    var item: Assignment
    var idSelect: String
    
    init(item: Assignment, idSelect: String) {
        self.item = item
        self.idSelect = idSelect
    }
    
    func isMissed() -> Bool {
        return StatusWorkout(rawValue: item.status) == .misssed
    }
    
    func isCompleted() -> Bool {
        return StatusWorkout(rawValue: item.status) == .completed
    }

    func getNumberWorkout() -> String {
        return "• \(item.exercisesCount) exercises"
    }
    
    func getCompleted() -> String {
        return "Completed"
    }
    
    func getMissed() -> String {
        return "Missed"
    }
    
    func isSelect() -> Bool {
        return item.id == idSelect
    }
}
