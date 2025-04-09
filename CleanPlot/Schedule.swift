//
//  Schedule.swift
//  CleanPlot
//
//  Created by Mutakin on 27/03/25.
//

import SwiftData

@Model
class Schedule {
    var scheduleId: String
    @Relationship(deleteRule: .cascade) var assignments: [AssignmentRecord] = []
    
    init(scheduleId: String) {
        self.scheduleId = scheduleId
    }
}
