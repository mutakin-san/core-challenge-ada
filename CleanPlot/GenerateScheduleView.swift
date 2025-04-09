import SwiftUI
import SwiftData

struct GenerateScheduleView: View {
    @Query(sort: \Schedule.persistentModelID, order: .reverse) var schedules: [Schedule]
    
    @State private var selectedSegment = 0
    @State var showDeleteAlert = false
    @State var showConfigModal = false
    @State var modifyMember = false
    @State var showEditMemberStatus = false
    @State var indexSetToDelete: IndexSet? = nil
    
    @Query var members: [Member]
    private var activeMembers: [Member] {
        members.filter { $0.status }
    }
    
    @Environment(\.modelContext) var modelContext
    
    var currentSchedule: Schedule? {
        schedules.first { $0.endDate > Date() }
    }
    
    var scheduleHistories: [Schedule] {
        schedules.filter { i in
            true }
    }
    
    @State var showingGenerateAlert: Bool = false
    @State var showingResult = false
    @State var alertMessage: String = "Terjadi masalah! silahkan coba lagi."
    
    let areas = [
        "SML", "GOP 6", "GOP 1", "Gardu", "GOP 9",
        "Gate 1", "Gate 2", "Marketing", "Pucuk Merah",
        "Parkiran", "GOP 5", "Green Bell",
        "Sampah Gantung", "Mobile", "Mobile"
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header
                VStack(alignment: .leading) {
                    Text("Halo, Subur!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Buat Jadwal Tim Anda Sekarang!")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
                
                // Segmented Control
                Picker("", selection: $selectedSegment) {
                    Text("Jadwal Saat Ini").tag(0)
                    Text("Riwayat").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Content based on selection
                Group {
                    switch selectedSegment {
                    case 0:
                        CurrentScheduleView(
                            currentSchedule: currentSchedule,
                            showConfigModal: $showConfigModal,
                            showingResult: $showingResult
                        )
                    case 1:
                        ScheduleHistoryView(
                            scheduleHistories: scheduleHistories,
                            showDeleteAlert: $showDeleteAlert,
                            indexSetToDelete: $indexSetToDelete
                        )
                    default:
                        EmptyView()
                    }
                }
                .animation(.easeInOut, value: selectedSegment)
                
                Spacer()
                
                // Generate Schedule Button
                Button(action: {
                    showConfigModal = true
                }) {
                    Text("Buat Jadwal")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .alert(alertMessage, isPresented: $showingGenerateAlert) {
                Button("OK", role: .cancel) { }
            }
            .sheet(isPresented: $showConfigModal) {
                ConfigModalView(
                    activeMembers: activeMembers,
                    showEditMemberStatus: $showEditMemberStatus,
                    showConfigModal: $showConfigModal,
                    showingResult: $showingResult,
                    generateSchedule: generateSchedule
                )
            }
        }
    }
    
    func generateSchedule() {
        if activeMembers.isEmpty {
            showingGenerateAlert = true
            alertMessage = "Belum ada anggota!"
            return
        }
        let scheduler = FlexibleScheduler(
            members: members,
            areas: areas,
            modelContext: modelContext,
            rules: SchedulingRules(constraints: [.noRepeatArea(2), .noRepeatMember(2)])
        )
        let result = scheduler.generateSchedule()
        showConfigModal = false
        showingResult = true
        print(result)
    }
}

// - Subviews

struct CurrentScheduleView: View {
    let currentSchedule: Schedule?
    @Binding var showConfigModal: Bool
    @Binding var showingResult: Bool
    
    var body: some View {
        if(currentSchedule == nil) {
            VStack(alignment: .center) {
                Spacer()
                Text("Tidak ada jadwal")
                    .foregroundColor(.gray)
                Spacer()
            }
            
        } else {
            HStack {
                Text(currentSchedule?.scheduleId ?? "Unknown")
                
                Spacer()
                
                ShareLink(
                    item: """
                                                               \(currentSchedule?.scheduleId ?? "Unkonwn")
                                                               \(currentSchedule?.getAssignmentsText() ?? "Tidak ada data")
                                                               """)
                .labelStyle(.iconOnly)
            }
            .padding()
            
            
            List(currentSchedule?.sortByShift() ?? []) { assignment in
                
                HStack {
                    Image(.profilePicture)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .scaledToFill()
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(assignment.member.name)
                            
                            Spacer()
                            Text(assignment.area)
                            
                        }
                        Text(assignment.shiftType.description)
                            .font(.caption)
                        
                    }
                }
                
            }
            .listRowSpacing(10)
        }
        
    }//varbody
}

struct ScheduleHistoryView: View {
    let scheduleHistories: [Schedule]
    @Binding var showDeleteAlert: Bool
    @Binding var indexSetToDelete: IndexSet?
    
    var body: some View {
        if scheduleHistories.isEmpty {
            VStack {
                Spacer()
                Text("Belum ada riwayat jadwal")
                    .foregroundColor(.gray)
                Spacer()
            }
        } else {
            List {
                ForEach(scheduleHistories) { schedule in
                    NavigationLink {
                        DetailHistory(schedule: schedule)
                    } label: {
                        Text(schedule.scheduleId)
                    }
                }
                .onDelete { offsets in
                    indexSetToDelete = offsets
                    showDeleteAlert = true
                }
            }
            .listStyle(.plain)
            .padding(.top)
        }
    }
}

struct ConfigModalView: View {
    let activeMembers: [Member]
    @Binding var showEditMemberStatus: Bool
    @Binding var showConfigModal: Bool
    @Binding var showingResult: Bool
    let generateSchedule: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Atur anggota")
                        .font(.title3)
                    Text("Jumlah Anggota yang aktif (\(activeMembers.count) orang)")
                        .font(.caption)
                }
                Spacer()
                Button("Atur Anggota") {
                    showEditMemberStatus = true
                }
                .sheet(isPresented: $showEditMemberStatus) {
                    MemberStatusEditView(showEditMemberStatus: $showEditMemberStatus)
                }
            }
            Spacer()
            Button {
                generateSchedule()
            } label: {
                Text("Lanjutkan")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .presentationDetents([.fraction(0.3)])
    }
}

struct MemberStatusEditView: View {
    @Binding var showEditMemberStatus: Bool
    
    var body: some View {
        NavigationStack {
            MemberListView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Batal") {
                            showEditMemberStatus = false
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Selesai") {
                            showEditMemberStatus = false
                        }
                    }
                }
        }
    }
}

#Preview {
    GenerateScheduleView()
}
