//
//  GenerateScheduleView.swift
//  CleanPlot
//
//  Created by Mutakin on 27/03/25.
//

import SwiftUI
import SwiftData

struct GenerateScheduleView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var members: [Member]
    
    @Query private var assignments: [AssignmentRecord]
    
    @State private var assignmentsData: [Assignment] = []
    
    // Predefined areas as specified
    let areas = [
        "SML", "GOP 6", "GOP 1", "Gardu", "GOP 9",
        "Gate 1", "Gate 2", "Marketing", "Pucuk Merah",
        "Parkiran", "GOP 5", "Green Bell",
        "Sampah Gantung", "Mobile", "Mobile"
    ]
    
    
    var body: some View {
        VStack {
            Button("Generate Flexible Schedule") {
                // Areas can be predefined or dynamically created
                let areas = [
                        "SML", "GOP 6", "GOP 1", "Gardu", "GOP 9",
                        "Gate 1", "Gate 2", "Marketing", "Pucuk Merah",
                        "Parkiran", "GOP 5", "Green Bell",
                        "Sampah Gantung", "Mobile", "Mobile"
                    ]
                
                // Create custom scheduling rules
                var rules = SchedulingRules()
                rules.constraints = [
                    .noRepeatArea(2),           // Don't repeat area within 2 schedules
                    .noRepeatMember(3),          // Don't repeat member within 3 schedules
                    .minimumTimeBetween(14)      // At least 14 days between assignments
                ]
                rules.coverageStrategy = .balanced
                rules.scheduleDuration = 14      // Biweekly
                
                // Use existing members from SwiftData query
                let scheduler = FlexibleScheduler(
                    members: members,
                    areas: areas,
                    modelContext: modelContext,
                    rules: rules
                )
                
                // Generate schedule with custom parameters
                let assignments = scheduler.generateSchedule(
                    startDate: Date(),
                    numberOfAssignments: 5,  // Optional: specify number of assignments
                    customRules: nil         // Optional: override default rules
                )
                
                // Print assignments
                for assignment in assignments {
                    print("\(assignment.area): \(assignment.member)")
                }
            }
            List {
                Section(header: Text("Morning Shift")) {
                    ForEach(assignmentsData.filter { $0.shiftType == .morning }, id: \.member) { assignment in
                        HStack {
                            Text(assignment.area)
                            Spacer()
                            Text(assignment.member)
                        }
                    }
                }
                
                Section(header: Text("Afternoon Shift")) {
                    ForEach(assignmentsData.filter { $0.shiftType == .afternoon }, id: \.member) { assignment in
                        HStack {
                            Text(assignment.area)
                            Spacer()
                            Text(assignment.member)
                        }
                    }
                }
            }
        }.onAppear {
            
            assignmentsData = assignments.map { record in
                Assignment(member: record.memberName, area: record.area, shiftType: record.shiftType, scheduleId: record.scheduleId, date: record.date)
            }
            
        }
    }
    
}

#Preview {
    GenerateScheduleView()
}
