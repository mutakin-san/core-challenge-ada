//
//  DetailScheduleView.swift
//  ShinyShift
//
//  Created by Mutakin on 15/05/25.
//

import SwiftUI

struct DetailScheduleView: View {
    let schedule: ScheduleModel?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(
                            .adaptive(minimum: 200, maximum: 300)),
                        count: geometry.size.width > 200 ? 3 : 2)
                ) {
                    if let schedule = schedule {
                        ForEach(schedule.assignments) { assignment in
                            ZStack {
                                Color.gray.opacity(0.3)
                                VStack(alignment: .leading) {
                                    Text("\(assignment.area)")
                                        .font(.title3)
                                    Spacer()

                                    VStack(alignment: .leading) {
                                        Text("Assigned to")
                                            .font(.body)
                                        Text("\(assignment.member.name)")
                                            .font(.title2)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment:
                                            .leading)
                                }
                                .padding()
                            }
                            .cornerRadius(10)

                        }
                    }
                    
                }
            }
            .frame(maxHeight: geometry.size.height)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    DetailScheduleView(schedule: nil)
}
