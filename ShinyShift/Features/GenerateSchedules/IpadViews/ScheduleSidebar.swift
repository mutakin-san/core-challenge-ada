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
    @Binding var selection: ScheduleModel?

    @Query var schedules: [ScheduleModel]

    var currentSchedule: ScheduleModel? {
        schedules.first(where: { $0.endDate > Date() })
    }

    var upcomingSchedule: [ScheduleModel] {
        let today = Calendar.current.startOfDay(for: Date())
        return
            schedules
            .filter {
                Calendar.current.startOfDay(for: $0.startDate) > today
            }
            .sorted(by: { $0.startDate < $1.startDate })
    }

    var completedSchedule: [ScheduleModel] {
        schedules.filter { $0.endDate < Date() }.sorted {
            $0.endDate > $1.endDate
        }
    }

    var body: some View {
        if schedules.isEmpty {
            ScheduleEmptyView(selection: $selection)
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
                    isPresented: $showCreateScheduleSheet                ) {
                    CreateScheduleView { schedule in
                        selection = schedule
                    }
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        if let schedule = currentSchedule {
                            ScheduleListItem(
                                schedule: schedule,
                                isActive: selection == schedule
                            )
                            .onTapGesture {
                                selection = schedule
                            }
                        }

                        if !upcomingSchedule.isEmpty {
                            Text("Upcoming Schedules")
                                .padding(.top, 16)
                            ForEach(
                                upcomingSchedule, id: \.self
                            ) {
                                schedule in
                                ScheduleListItem(
                                    schedule: schedule,
                                    isActive: selection == schedule
                                )
                                .onTapGesture {
                                    selection = schedule
                                }
                            }
                        }

                        if !completedSchedule.isEmpty {
                            Text("Completed Schedules")
                                .padding(.top, 16)
                            ForEach(
                                completedSchedule, id: \.self
                            ) {
                                schedule in
                                ScheduleListItem(
                                    schedule: schedule,
                                    isActive: selection == schedule
                                )
                                .onTapGesture {
                                    selection = schedule
                                }
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
    @Previewable @State var selection: ScheduleModel? = nil
    ScheduleSidebar(selection: $selection)
}
