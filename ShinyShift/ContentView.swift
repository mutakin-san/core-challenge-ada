//
//  ContentView.swift
//  CleanPlot
//
//  Created by Mutakin on 26/03/25.
//

import Foundation
import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var columnVisibility =
        NavigationSplitViewVisibility.all
    @State private var selectedPage: String = "schedule"
    @State private var selectedSchedule: ScheduleModel? = nil

    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                Sidebar(selection: $selectedPage)
            } content: {
                if selectedPage == "schedule" {
                    ScheduleListContent(selection: $selectedSchedule)
                } else {
                    EmptyView()
                }
            } detail: {
                if selectedPage == "schedule" {
                    if let schedule = selectedSchedule {
                        DetailScheduleView(schedule: schedule)
                    } else {
                        Text("No schedule selected")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }

            }
        } else {
            TabView {
                Tab("Buat Jadwal", systemImage: "wand.and.rays") {
                    GenerateScheduleView()
                }
                Tab("Tim", systemImage: "person.2") {
                    MemberView()
                }
                Tab("Area", systemImage: "square.grid.2x2") {
                    AreaManagementView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
