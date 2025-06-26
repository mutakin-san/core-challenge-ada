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

    func isOverlappingWithRecentHistory(
        modelContext: ModelContext, newStart: Date, newEnd: Date
    ) -> Bool {
        let fetchDescriptor = FetchDescriptor<ScheduleModel>(
            sortBy: [SortDescriptor(\.startDate, order: .reverse)]
        )

        do {
            let recentHistory = try modelContext.fetch(fetchDescriptor).map {
                $0
            }
            return recentHistory.contains { history in
                newStart < history.endDate && newEnd > history.startDate
            }
        } catch {
            print("Error fetching history: \(error)")
            return false
        }

    }

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog
        & ShowsSnippetView
    {
        if isOverlappingWithRecentHistory(
            modelContext: sharedModelContainer.mainContext, newStart: startDate,
            newEnd: endDate)
        {
            throw Error.invalidDateRange
        }

        let dayOfStartDate = Calendar.current.component(.day, from: startDate)
        let dayOfEndDate = Calendar.current.component(.day, from: endDate)
        if startDate >= endDate || dayOfStartDate >= dayOfEndDate {
            throw Error.invalidDateRange
        }

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

        // Return result with custom view
        return .result(
            dialog:
                "Schedule generated for \(schedule.startDate.formatDate()) to \(schedule.endDate.formatDate())"
        ) {
            ScheduleSnippetView(schedule: schedule)
        }
    }

    enum Error: Swift.Error, CustomLocalizedStringResourceConvertible {
        case invalidDateRange
        case modelContextError
        case noMembersFound

        var localizedStringResource: LocalizedStringResource {
            switch self {
            case .invalidDateRange: return "Please choose valid date range"
            case .noMembersFound: return "No members found"
            case .modelContextError:
                return "Something went wrong, please try again"
            }
        }
    }
}

// View to display the schedule result
struct ScheduleSnippetView: View {
    let schedule: ScheduleModel

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Section(
                header: Text("Morning Shift 06.00 - 15.00 WIB")
                    .frame(maxWidth: .infinity, alignment: .leading)
            ) {
                ForEach(
                    schedule.assignments.filter({ assignment in
                        assignment.shiftType == ShiftType.morning
                    })
                ) { item in
                    Text(
                        "\(item.member.name) - \(item.area)"
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 1))
                    })
                }
            }
            Section(
                header: Text("Afternoon Shift 08.00 - 17.00 WIB")
                    .frame(maxWidth: .infinity, alignment: .leading)
            ) {
                ForEach(
                    schedule.assignments.filter({ assignment in
                        assignment.shiftType == ShiftType.afternoon
                    })
                ) { item in
                    Text(
                        "\(item.member.name) - \(item.area)"
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 1))
                    })
                }
            }

        }
        .padding()
    }
}

struct AppIntentShortcutProvider: AppShortcutsProvider {

    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GenerateScheduleIntent(),
            phrases: ["Generate schedule in \(.applicationName)", "Create Schedule on \(.applicationName)"],
            shortTitle: "Generate Schedule", systemImageName: "wand.and.rays")

    }

}
