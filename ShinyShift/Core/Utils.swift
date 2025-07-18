//
//  Utils.swift
//  CleanPlot
//
//  Created by Mutakin on 27/03/25.
//

import Foundation

// Enum to define shift types
enum ShiftType: String, Codable {
    case morning
    case afternoon
    
    var description: String {
        switch self {
        case .morning: return "Pagi"
        case .afternoon: return "Siang"
        }
    }
}


extension Date {
    func formatDate(_ format: String = "dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// Enum to represent different scheduling constraints
enum SchedulingConstraintType {
    case noRepeatArea(Int)        // Prevent repeating in same area within X schedules
    case noRepeatMember(Int)      // Prevent same member in same area within X schedules
    case minimumTimeBetween(Int)  // Minimum days between assignments
}

// Struct to define scheduling rules
struct SchedulingRules {
    var constraints: [SchedulingConstraintType] = []
    var scheduleDuration: Int = 14  // Default to biweekly, but configurable
    var coverageStrategy: CoverageStrategy = .balanced
}

// Enum for different coverage strategies
enum CoverageStrategy {
    case balanced       // Distribute work evenly
    case fairness       // Minimize variance in total work
    case recentHistory  // Prefer less recently worked members
}


extension ScheduleModel {
    func sortByShift() -> [AssignmentModel] {
        return self.assignments.sorted(by: {
            $0.shiftType.description < $1.shiftType.description
        })
    }
    
    func getAssignmentsText() -> String{
        var text = "\(self.scheduleId)\nShift Pagi (06.00 WIB): \n"
        let morningSchedule = self.assignments.filter({ $0.shiftType == .morning })
        let afternoonSchedule = self.assignments.filter({ $0.shiftType == .afternoon })

        for (index, item) in morningSchedule.enumerated() {
            text += "\(index + 1). \(item.member.name) - \(item.area)\n"
        }
        
        text += "\nShift Siang (08.00 WIB): \n"
        
        for (index, item) in afternoonSchedule.enumerated() {
            text += "\(index + 1). \(item.member.name) - \(item.area)\n"
        }

        
        return text
    }
}
