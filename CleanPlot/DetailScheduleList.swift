//
//  DetailHistory.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//

import SwiftUI

struct DetailScheduleList: View {
    let schedule: Schedule
    
    var body: some View {
        List {
            Section(header: Text("Shift Pagi 06.00 - 15.00 WIB")
                .frame(maxWidth: .infinity, alignment: .leading)){
                    ForEach(schedule.assignments.filter({ assignment in
                        assignment.shiftType == ShiftType.morning
                    })) {item in
                        DetailScheduleCard(item: item)
                    }
                }
            Section(header: Text("Shift Siang 08.00 - 17.00 WIB")
                .frame(maxWidth: .infinity, alignment: .leading)){
                    ForEach(schedule.assignments.filter({ assignment in
                        assignment.shiftType == ShiftType.afternoon
                    })) {item in
                        DetailScheduleCard(item: item)
                    }
                }
            
        }
        .listRowSpacing(10)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Text(schedule.scheduleId)
            }
            ToolbarItem(placement: .confirmationAction) {
                ShareLink(
                    item: """
                            \(schedule.scheduleId)
                            \(schedule.getAssignmentsText())
                            """)
                .labelStyle(.iconOnly)
            }
        }
        
        
        
        
        
        
        
        
    }
}

#Preview {
    let schedule: Schedule = Schedule(scheduleId: "Schedule: 13 March", startDate: Date(), endDate: Date())
    DetailScheduleList(schedule: schedule)
}

struct DetailScheduleCard: View {
    
    let item: AssignmentRecord
    
    var body: some View {
        
        HStack{
            //pp
            Image("ProfilePicture")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:50, height:50)
                .clipShape(Circle())
                .shadow(radius:2)
            
            //nama & no.hp
            HStack{
                Text(item.member.name)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(item.area)
                    .padding(.trailing)
                    .foregroundColor(.gray)
            }
        }
        
        .listRowSeparator(.hidden)
    }
    
}


