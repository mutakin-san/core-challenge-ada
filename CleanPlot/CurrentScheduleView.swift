//
//  CurrentScheduleView.swift
//  CleanPlot
//
//  Created by Mutakin on 09/04/25.
//


import SwiftUI
import SwiftData

struct CurrentScheduleView: View {
    let currentSchedule: Schedule?
    let areas: [String]
    
    @State private var selection = "SML"
    @State var editMode = false
    @Environment(\.modelContext) var modelContext

    
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
                        Text(editMode ? "Done" : "Edit")
                    }
                    
                    
                    ShareLink(
                        item: """
\(currentSchedule?.scheduleId ?? "Unkonwn")
\(currentSchedule?.getAssignmentsText() ?? "Tidak ada data")
""")
                    .labelStyle(.iconOnly)
                }
                .padding()
                
                
                List(currentSchedule?.sortByShift() ?? []) { assignment in
                    
                    HStack {
                        Image(.profilePicture)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .scaledToFill()
                            .clipShape(.circle)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(assignment.member.name)
                                
                                Spacer()
                                
                                if editMode {
                                    
                                    Picker("Area", selection: Binding(
                                        get: { assignment.area },
                                        set: { newValue in
                                            // Handle swap logic here
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
                                    )) {
                                        ForEach(areas, id: \.self) { area in
                                            Text(area)
                                        }
                                    }
                                    .labelsHidden()
                                    .frame(minWidth: 0, maxHeight: 30) // control height
                                    .clipped()
                                    .padding(0)
                                }
                                else {
                                    Text(assignment.area)
                                }
                            }
                            Text(assignment.shiftType.description)
                                .font(.caption)
                            
                        }
                    }
                    
                }
                .listRowSpacing(10)
            }
            
            
            
        }
    }
}
