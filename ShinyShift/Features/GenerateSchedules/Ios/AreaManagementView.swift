import SwiftUI
import SwiftData

struct AreaManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \AreaModel.name) private var areas: [AreaModel]
    @State private var newAreaName: String = ""
    @State private var editingArea: AreaModel? = nil
    @State private var editingName: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(areas) { area in
                    HStack {
                        if editingArea == area {
                            TextField("Nama Area", text: $editingName, onCommit: {
                                if !editingName.trimmingCharacters(in: .whitespaces).isEmpty {
                                    area.name = editingName.trimmingCharacters(in: .whitespaces)
                                    try? modelContext.save()
                                }
                                editingArea = nil
                            })
                        } else {
                            Text(area.name)
                            Spacer()
                            Button(action: {
                                editingArea = area
                                editingName = area.name
                            }) {
                                Image(systemName: "pencil")
                            }
                        }
                        Button(action: {
                            modelContext.delete(area)
                            try? modelContext.save()
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            HStack {
                TextField("Tambah Area", text: $newAreaName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Simpan") {
                    let trimmed = newAreaName.trimmingCharacters(in: .whitespaces)
                    guard !trimmed.isEmpty, !areas.contains(where: { $0.name == trimmed }) else { return }
                    let newArea = AreaModel(name: trimmed)
                    modelContext.insert(newArea)
                    try? modelContext.save()
                    newAreaName = ""
                }
            }
            .padding()
            .navigationTitle("Kelola Area")
        }
    }
}

#Preview {
    AreaManagementView()
} 
