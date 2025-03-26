//
//  MemberListView.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//

import SwiftUI

struct MemberListView: View {
    
    let items: [CardItem] = [
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"),
        CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture")
    ]
    
    var body: some View {
        NavigationStack {
            List (items) { item in
                MemberCard(item: item)
            }
            .listRowSpacing(10)
        }
    }
    
}

#Preview {
    MemberListView()
}
