//
//  DetailScheduleView.swift
//  ShinyShift
//
//  Created by Mutakin on 15/05/25.
//

import SwiftUI

struct DetailScheduleView: View {
    let schedule: ScheduleModel?
    @State private var isEditMode: Bool = false
    @State private var showShareSheet: Bool = false
    @Environment(\.modelContext) var modelContext
    
    var morningShift: [AssignmentModel] {
        schedule?.assignments.filter({ assigment in
            assigment.shiftType == .morning
        }) ?? []
    }

    var afternoonShift: [AssignmentModel] {
        schedule?.assignments.filter({ assigment in
            assigment.shiftType == .afternoon
        }) ?? []
    }
    
    private func swapMember(to newValue: Member,from assignment: AssignmentModel) -> Void {
        if let swapAssignment = schedule?.assignments.first(where: { $0.member.name == newValue.name }) {
            let temp = assignment.member
            assignment.member = swapAssignment.member
            swapAssignment.member = temp
        } else {
            assignment.member = newValue
        }
    }
    

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Navigation Bar
                HStack {
                    Spacer()
                    Button(action: {
                        isEditMode.toggle()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: isEditMode ? "checkmark.circle" : "pencil.circle")
                            Text(isEditMode ? "Done" : "Edit")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isEditMode ? .accent : .accent)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(isEditMode ? Color(.green).opacity(0.1) : .shadeGreen)
                                .stroke(.accent, lineWidth: 1)
                        )
                    }
                    
                    Button(action: {
                        showShareSheet = true
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.accent)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.shadeGreen)
                                .stroke(.accent, lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
                
                // Content
                ScrollView {
                    if schedule != nil {
                        DetailScheduleGrid(shiftName: "Morning Shift", shiftTime: "06.00 - 15.00", assignments: morningShift, onSwap: swapMember, isEditMode: isEditMode)
                        DetailScheduleGrid(shiftName: "Afternoon Shift", shiftTime: "08.00 - 17.00", assignments: afternoonShift, onSwap: swapMember, isEditMode: isEditMode)
                    }
                }
                .padding(.horizontal)
                .frame(maxHeight: geometry.size.height)
            }
        }
        .sheet(isPresented: $showShareSheet) {
            if let schedule = schedule {
                ShareSheet(activityItems: [schedule.getAssignmentsText()])
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    DetailScheduleView(schedule: nil)
}
