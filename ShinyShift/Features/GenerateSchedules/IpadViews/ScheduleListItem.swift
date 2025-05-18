//
//  ScheduleListItem.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftUI

struct ScheduleListItem: View {
    let schedule: ScheduleModel
    let isActive: Bool
    @Environment(\.modelContext) var modelContext
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("\(formatDate(schedule.startDate)) - \(formatDate(schedule.endDate))")
                    .fontWeight(.medium)
                Text("\(schedule.assignments.count) assignments")
                    .font(.caption)
            }
            Spacer()
            Image(systemName: "chevron.forward")
        }
        .padding()
        .background(
            isActive
                ? .accent : .white
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(.accent, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .foregroundStyle(
            isActive ? .white : .black)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 8, trailing: 0))
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            return Button(role: .destructive) {
                modelContext.delete(schedule)
                do{
                    try modelContext.save()
                }catch{
                    print("Error deleting member")
                }
            } label : {
                VStack {
                    Image(systemName: "trash.fill")
                    Text("Hapus")
                }
            }
            .tint(.red)
        }
        .listRowSeparator(.hidden)
    }
}

