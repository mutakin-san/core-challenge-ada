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
    
    @State var showingGenerateAlert: Bool = false
    @State var alertMessage: String = "Terjadi masalah! silahkan coba lagi."
    
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
            }
            
            Button(action: {
                generateSchedule()
            }) {
                
                Text("Buat Jadwal")
                    .font(.title3)
                    .frame(
                        maxWidth: .infinity)                        .fontWeight(.bold)
                
                
                
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            .alert(alertMessage, isPresented: $showingGenerateAlert) {
                Button("OK", role: .cancel) { }
            }
            
            
        }
    }
    
    
    func generateSchedule() {
        if members.isEmpty {
            showingGenerateAlert = true
            alertMessage = "Belum ada anggota!"
            return
        }
        let scheduler = FlexibleScheduler(members: members, areas: areas, modelContext: modelContext, rules: SchedulingRules(constraints: [.noRepeatArea(2), .noRepeatMember(2)]))
        // Generate schedule
        let result  = scheduler.generateSchedule()
        
        print(result)
        
    }
}


#Preview {
    GenerateScheduleView()
}
