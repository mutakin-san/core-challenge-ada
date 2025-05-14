//
//  SidebarContent.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftData
import SwiftUI

struct ScheduleSidebar: View {
    @State private var showCreateScheduleSheet: Bool = false
    @State private var selectedSchedule: ScheduleModel?

    @Query var schedules: [ScheduleModel]

    var currentSchedule: ScheduleModel? {
        schedules.first(where: { $0.endDate > Date() })
    }

    var upcomingSchedule: [ScheduleModel] {
        schedules.filter { $0.endDate > Date() }.sorted {
            $0.endDate < $1.endDate
        }
    }
    
    var completedSchedule: [ScheduleModel] {
        schedules.filter { $0.endDate < Date() }.sorted {
            $0.endDate > $1.endDate
        }
    }

    var body: some View {
        if schedules.isEmpty {
            ScheduleEmptyView()
        } else {
            VStack(alignment: .leading) {
                Button {
                    showCreateScheduleSheet = !showCreateScheduleSheet
                } label: {
                    Label("New Schedule", systemImage: "plus.square")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .bold()
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 16)
                .popover(
                    isPresented: $showCreateScheduleSheet, arrowEdge: .leading
                ) {
                    CreateScheduleView()
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        if let schedule = currentSchedule {
                            ScheduleListItem(
                                schedule: schedule,
                                isActive: selectedSchedule == schedule
                            )
                            .onTapGesture {
                                selectedSchedule = schedule
                            }
                        }
                       
                        Text("Coming Schedules")
                            .padding(.top, 16)
                        ForEach(
                            upcomingSchedule, id: \.self
                        ) {
                            schedule in
                            ScheduleListItem(
                                schedule: schedule,
                                isActive: selectedSchedule == schedule
                            )
                            .onTapGesture {
                                selectedSchedule = schedule
                            }
                        }
                        Text("Completed Schedules")
                            .padding(.top, 16)
                        ForEach(
                            completedSchedule, id: \.self
                        ) {
                            schedule in
                            ScheduleListItem(
                                schedule: schedule,
                                isActive: selectedSchedule == schedule
                            )
                            .onTapGesture {
                                selectedSchedule = schedule
                            }
                        }

                    }
                }
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ScheduleSidebar()
}
