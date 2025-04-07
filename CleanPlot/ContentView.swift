//
//  ContentView.swift
//  CleanPlot
//
//  Created by Mutakin on 26/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Generate", systemImage: "wand.and.rays") {
                GenerateScheduleView()
            }
            Tab("Tim", systemImage: "person.2") {
                MemberView()
            }
            Tab("Riwayat", systemImage: "clock") {
                HistoryView()
            }
        }
    }
}

#Preview {
    ContentView()
}
