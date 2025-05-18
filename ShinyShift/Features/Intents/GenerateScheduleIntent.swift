import AppIntents
import SwiftData
import SwiftUI

struct GenerateScheduleIntent: AppIntent {
    static var title: LocalizedStringResource = "Generate Schedule"
    static var description: IntentDescription = IntentDescription(
        "Generate a schedule between two dates")
    
    static var openAppWhenRun: Bool = false

    @Parameter(title: "Start Date")
    var startDate: Date

    @Parameter(title: "End Date")
    var endDate: Date

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ScheduleModel.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(
                for: schema, configurations: [modelConfiguration])
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog
        & ShowsSnippetView
    {
        // Validate dates
        guard endDate >= startDate else {
            throw Error.invalidDateRange
        }

        // Get model context

        // Fetch all members using SwiftData
        let membersFetchDescriptor = FetchDescriptor<Member>()
        guard
            let members = try? sharedModelContainer.mainContext.fetch(
                membersFetchDescriptor)
        else {
            throw Error.noMembersFound
        }

        // Ensure we have members
        guard !members.isEmpty else {
            throw Error.noMembersFound
        }

        // Create scheduler with static areas
        let scheduler = FlexibleScheduler(
            members: members,
            areas: Areas.all,
            modelContext: sharedModelContainer.mainContext
        )

        // Generate schedule
        let schedule = scheduler.generateSchedule(
            startDate: startDate,
            endDate: endDate
        )

        // Convert ScheduleModel to ScheduleItems for display
        let scheduleItems = schedule.assignments.map { assignment in
            ScheduleItem(
                date: assignment.date,
                description:
                    "\(assignment.member.name) - \(assignment.area) (\(assignment.shiftType.rawValue))"
            )
        }

        // Return result with custom view
        return .result(dialog: "Schedule generated for \(schedule.startDate.formatDate()) to \(schedule.endDate.formatDate())")
        {
            ScheduleSnippetView(schedule: scheduleItems)
        }
    }

    enum Error: Swift.Error {
        case invalidDateRange
        case modelContextError
        case noMembersFound
    }
}

// View to display the schedule result
struct ScheduleSnippetView: View {
    let schedule: [ScheduleItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Generated Schedule")
                .font(.headline)

            ForEach(schedule.sorted(by: { $0.date < $1.date })) { item in
                VStack(alignment: .leading) {
                    Text(
                        item.date.formatted(date: .abbreviated, time: .omitted)
                    )
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    Text(item.description)
                        .font(.body)
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
    }
}

// Define the schedule item model
struct ScheduleItem: Identifiable {
    let id = UUID()
    let date: Date
    let description: String
}

struct AppIntentShortcutProvider: AppShortcutsProvider {

    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GenerateScheduleIntent(),
            phrases: ["Generate schedule in \(.applicationName)"],
            shortTitle: "Generate Schedule", systemImageName: "wand.and.rays")

    }

}
