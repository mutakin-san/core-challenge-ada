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
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                Text("History")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                List(schedules) {
                    schedule in
                    
                    
                    NavigationLink {
                        DetailHistory(schedule: schedule)
                    } label: {
                        
                        
                        Text(schedule.scheduleId)
                        
                        
                        
                        
                    }
                }
                
            }
        }
    }
}

#Preview {
    HistoryView()
}
