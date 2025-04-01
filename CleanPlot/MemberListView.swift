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
    @State var activeMember: Member? = nil
    @State var showDeleteConfirmation = false
    @Environment(\.modelContext) var modelContext
    
    fileprivate func delete(_ member: Member) -> some View {
        return Button(role: .destructive) {
            modelContext.delete(member)
            do {
                try modelContext.save()
            } catch {
                print("Error deleting member!!")
            }        } label: {
                VStack {
                    Image(systemName: "trash.fill")
                    Text("Hapus")
                }
            }
            .tint(.red)
        
    }
    
    fileprivate func edit(_ member: Member) -> some View {
        return Button {
            activeMember = member
        } label: {
            VStack {
                Image(systemName: "pencil")
                Text("Ubah")
            }
        }
        .tint(Color(red: 255/255, green: 128/255, blue: 0/255))
    }
    
    var body: some View {
        List (members) { member in
            MemberCard(item: member)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    delete(member)
                    edit(member)
                }
            
        }
        .overlay(Group {
            if members.isEmpty {
                Text("Maaf, Sepertinya belum ada anggota yang ditambahkan").multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
        })
        .listRowSpacing(10)
        .sheet(item: $activeMember) {
            activeMember = nil
        } content: { member in
            AddMemberView(member: member)
        }
        
        
    }
    
}

#Preview {
    MemberListView()
}
