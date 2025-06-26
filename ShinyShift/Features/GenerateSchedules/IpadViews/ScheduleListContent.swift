//
//  SidebarContent.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftData
import SwiftUI

struct ScheduleListContent: View {
    @State private var showCreateSchedulePopover: Bool = false
    @Binding var selection: ScheduleModel?

    @Query var schedules: [ScheduleModel]
    @Environment(\.modelContext) var modelContext


    var currentSchedule: ScheduleModel? {
        schedules.first(where: { $0.endDate > Date() })
    }

    var upcomingSchedule: [ScheduleModel] {
        let dayOfCurrentSchedule = Calendar.current.startOfDay(
            for: currentSchedule?.startDate ?? Date())
        return
            schedules
            .filter {
                Calendar.current.startOfDay(for: $0.startDate)
                    > dayOfCurrentSchedule
            }
            .sorted(by: { $0.startDate < $1.startDate })
    }

    var completedSchedule: [ScheduleModel] {
        schedules.filter { $0.endDate < Date() }.sorted {
            $0.endDate > $1.endDate
        }
    }
    
    func deleteSchedule(_ schedule: ScheduleModel) {
        withAnimation {
            modelContext.delete(schedule)
            do{
                try modelContext.save()
                selection = nil
            }catch{
                print("Error deleting member")
            }
        }
    }

    var body: some View {
        if schedules.isEmpty {
            ScheduleEmptyView(selection: $selection)
        } else {
            VStack(alignment: .leading) {
                Button {
                    showCreateSchedulePopover.toggle()
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
                    isPresented: $showCreateSchedulePopover
                ) {
                    CreateScheduleView { schedule in
                        selection = schedule
                    }
                }
                List {
                    if let schedule = currentSchedule {
                        ScheduleListItem(
                            schedule: schedule,
                            isActive: selection == schedule,
                            onDelete: deleteSchedule
                        )
                        .onTapGesture {
                            selection = schedule
                        }
                    }

                    if !upcomingSchedule.isEmpty {
                        Text("Upcoming Schedules")
                            .listRowInsets(EdgeInsets())
                        ForEach(
                            upcomingSchedule, id: \.self
                        ) {
                            schedule in
                            ScheduleListItem(
                                schedule: schedule,
                                isActive: selection == schedule,
                                onDelete: deleteSchedule
                            )
                            .onTapGesture {
                                selection = schedule
                            }
                        }
                    }

                    if !completedSchedule.isEmpty {
                        Text("Completed Schedules")
                            .listRowInsets(EdgeInsets())
                        ForEach(
                            completedSchedule, id: \.self
                        ) {
                            schedule in
                            ScheduleListItem(
                                schedule: schedule,
                                isActive: selection == schedule,
                                onDelete: deleteSchedule
                            )
                            .onTapGesture {
                                selection = schedule
                            }
                        }

                    }

                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    @Previewable @State var selection: ScheduleModel? = nil
    ScheduleListContent(selection: $selection)
}
