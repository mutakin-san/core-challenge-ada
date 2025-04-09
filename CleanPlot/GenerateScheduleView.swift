//
//  GenerateScheduleView.swift
//  CleanPlot
//
//  Created by Zaidan Akmal on 27/03/25.
//


import SwiftUI
import SwiftData

struct GenerateScheduleView: View {
    
    @Query(sort: \Schedule.persistentModelID, order: .reverse) var schedules: [Schedule]
    
    @State var showDeleteAlert = false
    @State var showConfigModal = false
    @State var modifyMember = false
    @State var showEditMemberStatus = false
    @State var indexSetToDelete: IndexSet? = nil
    
    @Query var members: [Member]
    private var activeMembers: [Member] {
        members.filter { member in
            member.status
        }
    }
    @Environment(\.modelContext) var modelContext
    var currentSchedule: Schedule? {
        schedules.first { schedule in
            schedule.endDate > Date()
        }
    }
    
    var scheduleHistories: [Schedule] {
        schedules.filter { schedule in
            schedule.endDate < Date()
        }
    }
    
    @State var showingGenerateAlert: Bool = false
    @State var showingResult = false
    @State var alertMessage: String = "Terjadi masalah! silahkan coba lagi."
    
    let areas = [
        "SML", "GOP 6", "GOP 1", "Gardu", "GOP 9",
        "Gate 1", "Gate 2", "Marketing", "Pucuk Merah",
        "Parkiran", "GOP 5", "Green Bell",
        "Sampah Gantung", "Mobile", "Mobile 2"
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CurrentScheduleView(currentSchedule: currentSchedule, areas: areas)
                Spacer()
            }
            
            
            Button(action: {
                showConfigModal = true
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
            } message: {
                Text("Silahkan tambahkan anggota yang aktif")
            }
            .sheet(isPresented: $showingResult, content: {
                if currentSchedule != nil {
                    DetailHistory(schedule: currentSchedule!)
                }
            })
            .sheet(isPresented: $showConfigModal) {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Atur anggota").font(.title3)
                            Text("Jumlah Anggota yang aktif (\(activeMembers.count) orang").font(.caption)
                        }
                        Spacer()
                        Button("Atur Anggota") {
                            showEditMemberStatus = true
                        }
                        .sheet(isPresented: $showEditMemberStatus) {
                            HStack {
                                Button("Batal") {
                                    showEditMemberStatus.toggle()
                                }
                                Spacer()
                                Button("Selesai") {
                                    showEditMemberStatus.toggle()
                                }
                            }
                            .padding()
                            MemberListView(containStatus: true)
                        }
                    }
                    Spacer()
                    Button {
                        generateSchedule()
                    } label: {
                        Text("Lanjutkan") .fontWeight(.bold)
                    }
                    .buttonStyle(.borderedProminent)

                }
                .padding()
                .presentationDetents([.fraction(0.3)])
            }
            
            
        }
    }
    
    func generateSchedule() {
        if activeMembers.isEmpty {
            showingGenerateAlert = true
            alertMessage = "Belum ada anggota!"
            return
        }
        let scheduler = FlexibleScheduler(members: members, areas: areas, modelContext: modelContext, rules: SchedulingRules(constraints: [.noRepeatArea(2), .noRepeatMember(2)]))
        // Generate schedule
        let result  = scheduler.generateSchedule()
        
        showConfigModal = false
        showingResult = true
        
        print(result)
        
        
        
    }
}


#Preview {
    GenerateScheduleView()
}
