//
//  CreateScheduleView.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftData
import SwiftUI

struct CreateScheduleView: View {
    let completion: (ScheduleModel) -> Void
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var emptyActiveMemberError: Bool = false
    @State private var overlappingError: Bool = false
    @State private var invalidDateRangeError: Bool = false
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    @Query var members: [Member]
    private var activeMembers: [Member] {
        members.filter { $0.status }
    }
    
    @Environment(\.modelContext) var modelContext
    
    func isOverlappingWithRecentHistory(newStart: Date, newEnd: Date) -> Bool {
        let fetchDescriptor = FetchDescriptor<ScheduleModel>(
            sortBy: [SortDescriptor(\.startDate, order: .reverse)]
        )
        
        do {
            let recentHistory = try modelContext.fetch(fetchDescriptor).map { $0 }
            return recentHistory.contains { history in
                newStart < history.endDate && newEnd > history.startDate
            }
        } catch {
            print("Error fetching history: \(error)")
            return false
        }
        
    }
    
    func generateSchedule() {
        if activeMembers.isEmpty {
            emptyActiveMemberError = true
            return
        }
        
        if isOverlappingWithRecentHistory(newStart: startDate, newEnd: endDate) {
            overlappingError = true
            return
        }

        
        let dayOfStartDate = Calendar.current.component(.day, from: startDate)
        let dayOfEndDate = Calendar.current.component(.day, from: endDate)
        if startDate >= endDate || dayOfStartDate >= dayOfEndDate {
            invalidDateRangeError = true
            return
        }
        
        
        let scheduler = FlexibleScheduler(
            members: activeMembers,
            areas: Areas.all,
            modelContext: modelContext,
            rules: SchedulingRules(constraints: [.noRepeatArea(2), .noRepeatMember(2)])
        )
        
        let newSchedule = scheduler.generateSchedule(startDate: startDate, endDate: endDate)
        
        dismiss()
        completion(newSchedule)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Fixed Header
            HStack {
                Text("Create New Schedule")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button("Close", systemImage: "multiply") {
                    dismiss()
                }
                .font(.title2)
                .fontWeight(.bold)
                .labelStyle(.iconOnly)
            }
            .padding()

            Divider()

            // Scrollable content
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    DateTextField(title: "Start Date", date: $startDate)
                    DateTextField(title: "End Date", date: $endDate)

                    // Members
                    Text("Select Members")
                        .fontWeight(.semibold)

                    MemberConfigurationList()
                }
                .padding()
            }

            Divider()

            // Fixed Button
            Button(action: {
                // Generate schedule logic
                generateSchedule()
            }) {
                Text("Generate Schedule")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .cornerRadius(10)
                    .padding()
            }
            .alert("No Members Selected", isPresented: $emptyActiveMemberError) {
                Button("Ok") {
                    emptyActiveMemberError = false
                }
            } message: {
                Text("Please select at least one member to generate a schedule.")
            }
            .alert("Invalid Date Range", isPresented: $overlappingError) {
                Button("Ok") {
                    overlappingError = false
                }
            } message: {
                Text("Please ensure the date range outside of any existing schedule.")
            }
            .alert("Invalid Date Range", isPresented: $invalidDateRangeError) {
                Button("Ok") {
                    invalidDateRangeError = false
                }
            } message: {
                Text("Please ensure the date range is valid.")
            }

        }
        .padding()
        .frame(minWidth: 420)
    }
}

#Preview {
    CreateScheduleView(completion: {schedule in })
}
