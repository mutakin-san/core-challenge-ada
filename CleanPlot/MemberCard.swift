//
//  MemberCard.swift
//  CleanPlot
//
//  Created by Mutakin on 26/03/25.
//

import SwiftUI


struct MemberCard: View {
    var item: CardItem
    
    var body: some View {
        
        HStack{
            //pp
            Image(item.pp)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:50, height:50)
                .clipShape(Circle())
            
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
        .padding()
        
    }
}

#Preview {
    MemberCard(item: CardItem(nama: "Endang", noHP: +627839201938, pp: "ProfilePicture"))
}
