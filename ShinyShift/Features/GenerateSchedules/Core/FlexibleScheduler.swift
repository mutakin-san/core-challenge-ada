//
//  FlexibleScheduler.swift
//  CleanPlot
//
//  Created by Mutakin on 27/03/25.
//


import SwiftData
import Foundation


class FlexibleScheduler {
    private let members: [Member]
    private let areas: [String]
    private let modelContext: ModelContext
    private var rules: SchedulingRules
    
    init(
        members: [Member], 
        areas: [String], 
        modelContext: ModelContext, 
        rules: SchedulingRules = SchedulingRules()
    ) {
        self.members = members
        self.areas = areas
        self.modelContext = modelContext
        self.rules = rules
    }
    
    // Generate schedule with flexible parameters
    func generateSchedule(
        startDate: Date = Date(),
        endDate: Date? = nil,
        numberOfAssignments: Int? = nil,
        customRules: SchedulingRules? = nil
    ) -> ScheduleModel {
        // Use custom rules if provided, otherwise use default
        let activeRules = customRules ?? rules
        
        // Determine number of assignments
        let assignmentsToGenerate = numberOfAssignments ?? areas.count
        
        // Fetch recent history to apply constraints
        let recentHistory = fetchRecentHistory()
        
        
            
        var assignments: [Assignment] = []
        var availableMembers = Set(members)
        var availableAreas = Set(areas)
        
        
        // Generate schedule ID based on start date and 2 weeks after
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"

        // Start date
        let startString = dateFormatter.string(from: startDate)
        let tempEndDate = endDate ?? Calendar.current.date(byAdding: .day, value: 14, to: startDate) ?? startDate
        
        
        
        let endString = dateFormatter.string(from: tempEndDate)
        
        let scheduleId = "\(startString) - \(endString)"
        
        // Calculate preference scores based on coverage strategy
        var memberScores = calculateMemberScores(
            history: recentHistory, 
            strategy: activeRules.coverageStrategy
        )
        
        // Initialize shift counters
        var morningShiftCount = 0
        var afternoonShiftCount = 0
        
        // Assignment generation loop
        while assignments.count < assignmentsToGenerate && 
              !availableMembers.isEmpty && 
              !availableAreas.isEmpty {
            
            // Find best member-area pair considering constraints and scores
            if let bestPair = findBestAssignment(
                availableMembers: availableMembers,
                availableAreas: availableAreas,
                currentAssignments: assignments,
                memberScores: &memberScores,
                recentHistory: recentHistory,
                rules: activeRules,
                startDate: startDate
            ) {
                
                // Determine shift type based on balancing counts
                let shiftType: ShiftType
                
                if morningShiftCount < afternoonShiftCount {
                    // Need more morning shifts to balance
                    shiftType = .morning
                } else if afternoonShiftCount < morningShiftCount {
                    // Need more afternoon shifts to balance
                    shiftType = .afternoon
                } else {
                    // Counts are equal, use another strategy (like alternating)
                    shiftType = assignments.count % 2 == 0 ? .morning : .afternoon
                }
                
                
                
                let assignment = Assignment(
                    member: bestPair.member,
                    area: bestPair.area,
                    shiftType: shiftType,
                    scheduleId: scheduleId,
                    date: startDate
                )
                
                // Update shift counters
                if shiftType == .morning {
                    morningShiftCount += 1
                } else {
                    afternoonShiftCount += 1
                }
                
                assignments.append(assignment)
                
                // Remove assigned member and area
                availableMembers.remove(bestPair.member)
                availableAreas.remove(bestPair.area)
                
                // Update member scores
                memberScores[bestPair.member.name] = (memberScores[bestPair.member.name] ?? 0) + 1
            } else {
                // If no valid assignment found, break to prevent infinite loop
                print("Could not find valid assignment")
                break
            }
        }
        
        // Save assignments to history
        return saveSchedule(scheduleId: scheduleId, startDate: startDate, endDate: tempEndDate, assignments: assignments)
    }
    
    // Find the best assignment considering multiple constraints
    private func findBestAssignment(
        availableMembers: Set<Member>,
        availableAreas: Set<String>,
        currentAssignments: [Assignment],
        memberScores: inout [String: Int],
        recentHistory: [AssignmentModel],
        rules: SchedulingRules,
        startDate: Date
    ) -> (member: Member, area: String, score: Double)? {
        // Create candidate pairs with scores
        var candidatePairs: [(member: Member, area: String, score: Double)] = []
        
        for member in availableMembers {
            for area in availableAreas {
                let score = calculateAssignmentScore(
                    member: member,
                    area: area,
                    currentAssignments: currentAssignments,
                    recentHistory: recentHistory,
                    rules: rules,
                    startDate: startDate,
                    memberScores: memberScores
                )
                
                candidatePairs.append((member, area, score))
            }
        }
        
        // Sort by score in descending order
        candidatePairs.sort { $0.score > $1.score }
        
        // Return the top scoring valid pair
        return candidatePairs.first
    }
    
    // Complex scoring mechanism considering multiple factors
    private func calculateAssignmentScore(
        member: Member,
        area: String,
        currentAssignments: [Assignment],
        recentHistory: [AssignmentModel],
        rules: SchedulingRules,
        startDate: Date,
        memberScores: [String: Int]
    ) -> Double {
        var score: Double = 0
        
        // Base score based on how recently member worked in this area
        let recentAreaAssignments = recentHistory.filter { 
            $0.member.name == member.name && $0.area == area
        }
        
        // Apply constraint checks
        for constraint in rules.constraints {
            switch constraint {
            case .noRepeatArea(let limit):
                if recentAreaAssignments.count >= limit {
                    return -Double.infinity  // Prevent repeat if limit reached
                }
            case .noRepeatMember(let limit):
                let recentMemberAssignments = recentHistory.filter { 
                    $0.member.name == member.name
                }
                if recentMemberAssignments.count >= limit {
                    return -Double.infinity
                }
            case .minimumTimeBetween(let days):
                if let lastAssignment = recentAreaAssignments.max(by: { $0.date < $1.date }) {
                    let daysSinceLastAssignment = Calendar.current.dateComponents(
                        [.day], 
                        from: lastAssignment.date, 
                        to: startDate
                    ).day ?? 0
                    
                    if daysSinceLastAssignment < days {
                        return -Double.infinity
                    }
                }
            }
        }
        
        // Score based on time since last worked in area
        if let lastAssignment = recentAreaAssignments.max(by: { $0.date < $1.date }) {
            let daysSinceLastWorked = Calendar.current.dateComponents(
                [.day], 
                from: lastAssignment.date, 
                to: startDate
            ).day ?? 0
            
            score += Double(daysSinceLastWorked)
        } else {
            // Never worked in this area before - high preference
            score += 1000
        }
        
        // Adjust score based on member's current workload
        if let currentWorkload = memberScores[member.name] {
            score -= Double(currentWorkload) * 10  // Penalize overworked members
        }
        
        return score
    }
    
    // Fetch recent historical assignments
    private func fetchRecentHistory(limit: Int = 100) -> [AssignmentModel] {
        let fetchDescriptor = FetchDescriptor<AssignmentModel>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(fetchDescriptor).prefix(limit).map { $0 }
        } catch {
            print("Error fetching history: \(error)")
            return []
        }
    }
    
    // Calculate initial member scores based on coverage strategy
    private func calculateMemberScores(
        history: [AssignmentModel], 
        strategy: CoverageStrategy
    ) -> [String: Int] {
        switch strategy {
        case .balanced:
            // Count total assignments per member
            var memberAssignmentCount: [String: Int] = [:]
            for record in history {
                memberAssignmentCount[record.member.name, default: 0] += 1
            }
            return memberAssignmentCount
        
        case .fairness:
            // More complex fairness calculation
            // Could involve looking at variance in assignment counts
            return [:]
        
        case .recentHistory:
            // Prefer members with fewer recent assignments
            return [:]
        }
    }
    
    // Save assignments to database
    private func saveSchedule(scheduleId: String, startDate: Date, endDate: Date, assignments: [Assignment]) -> ScheduleModel {
        let assignmentRecords: [AssignmentModel] = assignments.map { assignment in
            AssignmentModel(
                member: assignment.member,
                area: assignment.area,
                scheduleId: assignment.scheduleId, 
                date: assignment.date,
                shiftType: assignment.shiftType
            )
        }
        
        let schedule = ScheduleModel(scheduleId: scheduleId, startDate: startDate, endDate: endDate)
        schedule.assignments.append(contentsOf: assignmentRecords)
        modelContext.insert(schedule)

        do {
            try modelContext.save()
        } catch {
            print("Error saving assignments: \(error)")
        }
        
        return schedule
        
    }
}
