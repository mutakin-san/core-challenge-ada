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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Member.self,
            AssignmentRecord.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            Member.defaults.forEach { member in
                container.mainContext.insert(member)
            }
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(sharedModelContainer)
    }
}
