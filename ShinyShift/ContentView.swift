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

    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                Sidebar(selection: $selectedPage)
            } content: {
                if selectedPage == "schedule" {
                    ScheduleSidebar()
                } else {
                    EmptyView()
                }
            } detail: {

            }
        } else {
            TabView {
                Tab("Buat Jadwal", systemImage: "wand.and.rays") {
                    GenerateScheduleView()
                }
                Tab("Tim", systemImage: "person.2") {
                    MemberView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
