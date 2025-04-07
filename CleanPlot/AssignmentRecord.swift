import SwiftData
import Foundation

@Model
class AssignmentRecord {
    @Relationship(deleteRule: .noAction) var member: Member
    var area: String
    var scheduleId: String
    var date: Date
    var shiftType: ShiftType

    init(member: Member, area: String, scheduleId: String, date: Date, shiftType: ShiftType) {
        self.member = member
        self.area = area
        self.scheduleId = scheduleId
        self.date = date
        self.shiftType = shiftType
    }
    
    var description: String {
        return "\(member.name) - \(area)"
    }
}
