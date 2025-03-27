import SwiftData
import Foundation

@Model
class AssignmentRecord {
    var memberName: String
    var area: String
    var scheduleId: String
    var date: Date
    var shiftType: ShiftType

    init(memberName: String, area: String, scheduleId: String, date: Date, shiftType: ShiftType) {
        self.memberName = memberName
        self.area = area
        self.scheduleId = scheduleId
        self.date = date
        self.shiftType = shiftType
    }
    
    var description: String {
        return "\(memberName) - \(area)"
    }
}
