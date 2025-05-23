//
//  MemberView.swift
//  PakSuburAPP
//
//  Created by Frewin Saputra on 25/03/25.
//

import SwiftUI


struct MemberView : View {
    @State private var isSheetPresented = false

    
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
                .fontWeight(.bold)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .sheet(isPresented: $isSheetPresented) {
                    AddMemberView(member: nil)
                }
                
                MemberListView(containStatus: false)
                
                
            }
            .navigationTitle("Anggota Tim")
        }
    }
}


#Preview {
    MemberView()
}
