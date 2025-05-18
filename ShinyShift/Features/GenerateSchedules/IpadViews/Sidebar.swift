//
//  Sidebar.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selection: String
    
    var body: some View {
        List {
            Text("Shiny Shift")
                .foregroundStyle(.accent)
                .font(.largeTitle)
                .fontWeight(.bold)
            SidebarItem(
                isActive: selection == "schedule", text: "Schedule",
                systemImage: "wand.and.rays"
            )
            .onTapGesture {
                selection = "schedule"
            }
            SidebarItem(
                isActive: selection == "team", text: "Team",
                systemImage: "person.2"
            )
            .onTapGesture {
                selection = "team"
            }
        }
        .listStyle(.sidebar)
        .background(.shadeGreen)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    @Previewable @State var selectedPage: String = "schedule"
    Sidebar(selection: $selectedPage)
}
