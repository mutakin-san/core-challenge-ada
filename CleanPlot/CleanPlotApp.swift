//
//  CleanPlotApp.swift
//  CleanPlot
//
//  Created by Mutakin on 26/03/25.
//

import SwiftUI
import SwiftData

@main
struct CleanPlotApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [
            Member.self
        ])
    }
}
