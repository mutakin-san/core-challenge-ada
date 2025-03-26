//
//  MemberListView.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//

import SwiftUI

struct MemberListView: View {
    
    @Binding var members: [MemberModel]
    
    var body: some View {
        NavigationStack {
            List (members, id: \.id) { item in
                MemberCard(item: item)
            }
            .listRowSpacing(10)
        }
    }
    
}

#Preview {
    @Previewable @State var members: [MemberModel] = []
    MemberListView(members: $members)
}
