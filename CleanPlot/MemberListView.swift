//
//  MemberListView.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//

import SwiftUI
import SwiftData

struct MemberListView: View {
    
    @Query var members: [Member]
    
    var body: some View {
        NavigationStack {
            List (members) { member in
                MemberCard(item: member)
            }
            .listRowSpacing(10)
        }
    }
    
}

#Preview {
    MemberListView()
}
