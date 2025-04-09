import SwiftUI
import SwiftData

struct TeamMember: Identifiable {
    let id = UUID()
    let nama: String
    let area: String
    let noHP: Int
    let pp: String
}



struct ShiftView: View {
    var body: some View {
        NavigationView {
            List {
                Section{
                    ShiftPagi()
                        .listRowSeparator(.hidden)
                }
                
                Section{
                    ShiftSiang()
                        .listRowSeparator(.hidden)
                }
            }
            
            .listStyle(.insetGrouped)
            .listSectionSpacing(.custom(16))
            
        }.scrollContentBackground(.visible)//buat hilangin bg abu2
            
        
    }
}
struct ShiftPagi: View {
    
    @State var editMode = false
    @State private var selection = ""
    
    @State private var isExpanded = true
    let teamMembers = [
        TeamMember(nama: "Alex Johnson", area: "GOP 99", noHP:  1298319, pp: "manPicture"),
        TeamMember(nama: "Jamie Smith", area: "GOP 127", noHP: 123982193, pp: "manPicture"),
        TeamMember(nama: "Taylor Wilson", area: "GOP 12", noHP: 12412414, pp: "manPicture"),
        TeamMember(nama: "Morgan Lee", area: "GOP 81", noHP: 1242141, pp: "manPicture")
    ]
    
    let area = [
                "SML", "GOP 6", "GOP 1", "Gardu", "GOP 9",
                "Gate 1", "Gate 2", "Marketing", "Pucuk Merah",
                "Parkiran", "GOP 5", "Green Bell",
                "Sampah Ganging", "Mobile", "Mobile"
            ]
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            ForEach(teamMembers) { member in
                HStack(spacing: 12) {
                    // Profile Image
                    Image(member.pp)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(.circle)
                        .padding(.leading, -16)
                    
                    // Member Details
                    VStack(alignment: .leading) {
                        Text(member.nama)
                            .font(.headline)
                        
                        Text(String(member.noHP))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    
                    
                }
                .padding(.vertical, 8)
            }
        }
        
        label: {
            Text("Shift Pagi")
                .font(.headline)
                .padding(.vertical, 16)
        }
    }
}

struct ShiftSiang: View {
    
    @State private var isExpanded = true
    let teamMembers = [
        TeamMember(nama: "Alex Johnson", area: "GOP 99", noHP:  1298319, pp: "manPicture"),
        TeamMember(nama: "Jamie Smith", area: "GOP 127", noHP: 123982193, pp: "manPicture"),
        TeamMember(nama: "Taylor Wilson", area: "GOP 12", noHP: 12412414, pp: "manPicture"),
        TeamMember(nama: "Morgan Lee", area: "GOP 81", noHP: 1242141, pp: "manPicture")
    ]
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded){
            ForEach(teamMembers) { member in
                HStack(spacing: 12) {
                    // Profile Image
                    Image(member.pp)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(.circle)
                        .padding(.leading, -16)
                    
                    // Member Details
                    VStack(alignment: .leading) {
                        Text(member.nama)
                            .font(.headline)
                        
                        Text(String(member.noHP))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        
                    }
                    Spacer()
                    Text(member.area)
                        .font(.body)
                    
                }
                .padding(.vertical, 8)
            }
        }
        
        label: {
            Text("Shift Siang")
                .font(.headline)
                .padding(.vertical, 16)
        }
    }
}



struct MorningShiftView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftView()
    }
}

