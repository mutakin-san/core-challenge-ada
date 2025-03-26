//
//  MemberListView.swift
//  PakSuburAPP
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
        List (items) {item in
            ScrollView {
                VStack {
                    GroupBox(){
                        HStack{
                            //pp
                            Image(item.pp)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:50, height:50)
                                .clipShape(Circle())
                                .shadow(radius:2)
                            
                            //nama & no.hp
                            VStack{
                                Text(item.nama)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(item.noHP)")
                                    .font(.system(size: 10))
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        
                    }
                    
                    
                }
            }
            
        }
    }
        
}

#Preview {
    MemberListView()
}
