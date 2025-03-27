//
//  Utils.swift
//  CleanPlot
//
//  Created by Mutakin on 27/03/25.
//

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
