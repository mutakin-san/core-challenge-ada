//
//  GenerateScheduleView.swift
//  CleanPlot
//
//  Created by Zaidan Akmal on 27/03/25.
//


import SwiftUI
import SwiftData

struct GenerateScheduleView: View {
    
    @Query var schedules: [Schedule]
    @Query var members: [Member]
    @Environment(\.modelContext) var modelContext
    var currentSchedule: Schedule? {
        schedules.last
    }
    
    var currentScheduleAssignments: [AssignmentRecord] {
        currentSchedule?.assignments.sorted(by: {
            $0.shiftType.description < $1.shiftType.description
        }) ?? []
    }

    let areas = [
            "SML", "GOP 6", "GOP 1", "Gardu", "GOP 9",
            "Gate 1", "Gate 2", "Marketing", "Pucuk Merah",
            "Parkiran", "GOP 5", "Green Bell",
            "Sampah Ganging", "Mobile", "Mobile"
        ]
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .center) {
                    
                    Text("Halo, Subur!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Buat Jadwal Tim Anda Sekarang!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(.subheadline)
                    
                
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
                            
                            ShareLink(item: /*@START_MENU_TOKEN@*/URL(string: "https://developer.apple.com/xcode/swiftui")!/*@END_MENU_TOKEN@*/)
                                .labelStyle(.iconOnly)
                        }
                        .padding()
                        
                        
                        List(currentScheduleAssignments) { assignment in
                            
                            HStack {
                                Image(.manPicture)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(assignment.memberName)
                                        
                                        Spacer()
                                        Text(assignment.area)
                                        
                                    }
                                    Text(assignment.shiftType.description)
                                        .font(.caption)
                                    
                                }
                            }
                            
                        }
                        .listRowSpacing(10)
                    }
                    
                    
                    
                }
                Spacer()
                Spacer()
                
            }
            
            Button(action: {
                generateSchedule()
            }) {
                ZStack {
                    Rectangle()
                        .frame(height: 55.0)
                        .padding()
                        .foregroundStyle(.blue)
                    Text("Generate")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                }
            }
            
            
        }
    }
    
    
    func generateSchedule() {
        let scheduler = FlexibleScheduler(members: members, areas: areas, modelContext: modelContext)
        // Generate schedule
        scheduler.generateSchedule()
        
        print(schedules)
        
    }
}


#Preview {
    GenerateScheduleView()
}
