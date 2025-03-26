//
//  MemberView.swift
//  PakSuburAPP
//
//  Created by Frewin Saputra on 25/03/25.
//

import SwiftUI


struct MemberView : View {
    @State private var isSheetPresented = false
    @State private var members: [Member] = []

    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    isSheetPresented = true
                } label: {
                    Label("Tambah Member", systemImage: "plus.square.dashed")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .sheet(isPresented: $isSheetPresented) {
                    AddMemberView(isSheetPresented: $isSheetPresented, members: $members)
                }
                
                MemberListView(members: $members)
                
                
            }
            .navigationTitle("Member")
        }
    }
}


#Preview {
    MemberView()
}
