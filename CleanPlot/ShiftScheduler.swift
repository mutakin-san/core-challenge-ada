//
//  ShiftScheduler.swift
//  CleanPlot
//
//  Created by Mutakin on 27/03/25.
//

import SwiftData
import Foundation

// Modified Scheduler to support shift-based assignments
class ShiftScheduler {
    private let members: [Member]
    private let areas: [String]
    private let modelContext: ModelContext
    
    // Shift distribution parameters
    private let morningShiftRatio: Double
    private let afternoonShiftRatio: Double
    
    init(
        members: [Member], 
        areas: [String], 
        modelContext: ModelContext,
        morningShiftRatio: Double = 0.5,
        afternoonShiftRatio: Double = 0.5
    ) {
        self.members = members
        self.areas = areas
        self.modelContext = modelContext
        self.morningShiftRatio = morningShiftRatio
        self.afternoonShiftRatio = afternoonShiftRatio
    }
    
    // Generate schedule with shift assignments
    func generateSchedule(
        startDate: Date = Date(), 
        customAreas: [String]? = nil
    ) -> [ShiftAssignment] {
        let scheduledAreas = customAreas ?? areas
        
        // Calculate number of assignments for each shift
        let totalAreas = scheduledAreas.count
        let morningAssignmentCount = Int(Double(totalAreas) * morningShiftRatio)
        let afternoonAssignmentCount = totalAreas - morningAssignmentCount
        
        // Fetch recent history
        let recentHistory = fetchRecentHistory()
        
        // Generate schedule ID
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let scheduleId = "Schedule: \(dateFormatter.string(from: startDate))"
        
        // Shuffle members and areas for randomization
        var availableMembers = members.shuffled()
        var availableMorningAreas = scheduledAreas.shuffled().prefix(morningAssignmentCount)
        var availableAfternoonAreas = scheduledAreas.shuffled().suffix(afternoonAssignmentCount)
        
        var shiftAssignments: [ShiftAssignment] = []
        
        // Assign Morning Shifts
        let morningShiftMembers = availableMembers.prefix(availableMorningAreas.count)
        let morningAssignments = zip(morningShiftMembers, availableMorningAreas).map { member, area in
            ShiftAssignment(
                member: member.name, 
                area: area, 
                shiftType: .morning, 
                scheduleId: scheduleId, 
                date: startDate
            )
        }
        shiftAssignments.append(contentsOf: morningAssignments)
        
        // Assign Afternoon Shifts
        let afternoonShiftMembers = availableMembers.suffix(availableAfternoonAreas.count)
        let afternoonAssignments = zip(afternoonShiftMembers, availableAfternoonAreas).map { member, area in
            ShiftAssignment(
                member: member.name, 
                area: area, 
                shiftType: .afternoon, 
                scheduleId: scheduleId, 
                date: startDate
            )
        }
        shiftAssignments.append(contentsOf: afternoonAssignments)
        
        // Save assignments to history
        saveAssignments(shiftAssignments)
        
        return shiftAssignments
    }
    
    // Save assignments to database
    private func saveAssignments(_ assignments: [ShiftAssignment]) {
        for assignment in assignments {
            let record = AssignmentRecord(
                memberName: assignment.member, 
                area: assignment.area, 
                scheduleId: assignment.scheduleId, 
                date: assignment.date,
                shiftType: assignment.shiftType
            )
            modelContext.insert(record)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving assignments: \(error)")
        }
    }
    
    // Fetch recent historical assignments
    private func fetchRecentHistory(limit: Int = 100) -> [AssignmentRecord] {
        let fetchDescriptor = FetchDescriptor<AssignmentRecord>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(fetchDescriptor).prefix(limit).map { $0 }
        } catch {
            print("Error fetching history: \(error)")
            return []
        }
    }
}
