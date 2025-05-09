//
//  HistoryView.swift
//  CleanPlot
//
//  Created by Zaidan Akmal on 27/03/25.
//


import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \Schedule.persistentModelID, order: .reverse) var schedules: [Schedule]
    @Environment(\.modelContext) var modelContext
    @State var showDeleteAlert = false
    @State var indexSetToDelete: IndexSet? = nil

    var body: some View {
        NavigationStack {
            VStack {
                if schedules.isEmpty {
                    Text("Belum ada riwayat jadwal").foregroundStyle(.secondary)
                }
                else {
                    List {
                        ForEach(schedules) {
                            schedule in
                            NavigationLink {
                                DetailScheduleList(schedule: schedule)
                            } label: {
                                Text(schedule.scheduleId)
                            }
                        }.onDelete { offsets in
                            indexSetToDelete = offsets
                            showDeleteAlert = true
                        }
                        
                    }
                }
            }
            .navigationTitle("Riwayat")
            .alert("Hapus Data", isPresented: $showDeleteAlert) {
                Button("Hapus", role: .destructive) {
                    if let offsets = indexSetToDelete {
                        for offset in offsets {
                            let schedule = schedules[offset]
                            modelContext.delete(schedule)
                        }
                    }
                    indexSetToDelete = nil
                }
                Button("Batal", role: .cancel) {
                    indexSetToDelete = nil
                }
            } message: {
                Text("Apakah Anda yakin ingin menghapus data ini?")
            }
        }
    }
}

#Preview {
    HistoryView()
}
