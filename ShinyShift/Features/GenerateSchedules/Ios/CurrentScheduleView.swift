//
//  CurrentScheduleView.swift
//  CleanPlot
//
//  Created by Mutakin on 09/04/25.
//


import SwiftUI
import SwiftData

struct CurrentScheduleView: View {
    let currentSchedule: ScheduleModel?
    let areas: [String]
    
    @State private var selection = "SML"
    @State var editMode = false
    @Environment(\.modelContext) var modelContext
    
    
    private func swapArea(to newValue: String,from assignment: AssignmentModel) -> Void {
        if let swapAssignment = currentSchedule?.assignments.first(where: { $0.area == newValue }) {
            let temp = assignment.area
            assignment.area = swapAssignment.area
            swapAssignment.area = temp
        } else {
            assignment.area = newValue
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving assignments: \(error)")
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if(currentSchedule == nil) {
                VStack(alignment: .center) {
                    Spacer()
                    Text("Tidak ada jadwal")
                        .foregroundColor(.gray)
                    Spacer()
                }
                
            } else {
                HStack {
                    Text(currentSchedule?.scheduleId ?? "Unknown")
                    
                    Spacer()
                    
                    Button {
                        editMode = !editMode
                    } label: {
                        Text(editMode ? "Selesai" : "Ubah")
                    }
                    .padding(.trailing, 4)
                    
                    
                    ShareLink(
                        item: currentSchedule?.getAssignmentsText() ?? "Tidak ada data")
                    .labelStyle(.iconOnly)
                }
                .padding()
                
                
                List {
                    Section(header: Text("Shift Pagi 06.00 - 15.00 WIB")) {
                        ForEach(currentSchedule?.assignments.filter({ assignment in
                            assignment.shiftType == ShiftType.morning
                        }) ?? []) { assignment in
                            AssignmentCard(assignment: assignment, areas: areas, editMode: editMode) { newValue in
                                swapArea(to: newValue, from: assignment)
                            }
                        }
                    }
                    Section(header: Text("Shift Siang 08.00 - 17.00 WIB")) {
                        ForEach(currentSchedule?.assignments.filter({ assignment in
                            assignment.shiftType == ShiftType.afternoon
                        }) ?? []) { assignment in
                            AssignmentCard(assignment: assignment, areas: areas, editMode: editMode) { newValue in
                                swapArea(to: newValue, from: assignment)
                            }
                        }
                    }
                    
                    
                }
                .listRowSpacing(10)
            }
            
            
            
        }
    }
}
