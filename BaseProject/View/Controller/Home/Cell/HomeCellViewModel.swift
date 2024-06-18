import Foundation

final class HomeCellViewModel {
    
    private(set) var item: DayDatum
    private(set) var isToday: Bool
    private(set) var idSelect: String
    
    init(item: DayDatum, isToday: Bool, idSelect: String) {
        self.item = item
        self.isToday = isToday
        self.idSelect = idSelect
        //item.updateAssignmentSelection(withId: idSelect)
    }
}
