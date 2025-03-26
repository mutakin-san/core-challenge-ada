//
//  MemberView.swift
//  PakSuburAPP
//
//  Created by Frewin Saputra on 25/03/25.
//

import SwiftUI

struct Member {
    var name: String
    var shiftTime: String
    var area: String
}

struct MemberView : View {
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Button {
                    
                } label: {
                    Label("Tambah Member", systemImage: "plus.square.dashed")
                        .frame(maxWidth: .infinity, maxHeight: 64)
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderedProminent)
                
                MemberListView()
                
                
            }
            .navigationTitle("Member")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(Color.blue)
                }
                
            }
            .padding()
        }
    }
}


#Preview {
    MemberView()
}
