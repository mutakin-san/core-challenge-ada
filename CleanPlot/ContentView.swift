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
                Text("Hello World")
            }
            Tab("Member", systemImage: "person.2") {
                MemberView()
            }
            Tab("History", systemImage: "clock") {
                Text("Hello World")
            }
        }
    }
}

#Preview {
    ContentView()
}
