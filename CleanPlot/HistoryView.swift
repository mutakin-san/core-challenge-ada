//
//  HistoryView.swift
//  CleanPlot
//
//  Created by Zaidan Akmal on 27/03/25.
//


import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query var schedules: [Schedule]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                List {
                    ForEach(schedules) {
                        schedule in
                        NavigationLink {
                            DetailHistory(schedule: schedule)
                        } label: {
                            Text(schedule.scheduleId)
                        }
                    }.onDelete { offsets in
                        for offset in offsets {
                            let schedule = schedules[offset]
                            
                            modelContext.delete(schedule)
                        }
                    }
                    
                }
                
            }.navigationTitle("Riwayat")
        }
    }
}

#Preview {
    HistoryView()
}
