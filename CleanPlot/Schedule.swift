//
//  Schedule.swift
//  CleanPlot
//
//  Created by Mutakin on 27/03/25.
//

import SwiftData
import Foundation

@Model
class Schedule {
    var scheduleId: String
    @Relationship(deleteRule: .cascade) var assignments: [AssignmentRecord] = []
    var startDate: Date
    var endDate: Date
    
    init(scheduleId: String, startDate: Date, endDate: Date) {
        self.scheduleId = scheduleId
        self.startDate = startDate
        self.endDate = endDate
    }
}
