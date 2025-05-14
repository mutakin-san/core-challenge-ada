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

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(schedule.scheduleId)
                    .font(.title2)
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

    }
}

