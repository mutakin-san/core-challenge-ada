//
//  Member.swift
//  PakSuburAPP
//
//  Created by Frewin Saputra on 25/03/25.
//

import SwiftUI

struct MemberView : View {
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                //addMember
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .cornerRadius(12)
                    Image(systemName: "plus.square.dashed")
                        .resizable()
                        .frame(width:30, height: 30)
                        .foregroundColor(.white)
                }
                Divider()
                
                //ListMember
                MemberListView()
                    .navigationTitle("Member")
                    .toolbar {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(Color.blue)
  
                    }
            
            }
        }
    }
}

struct CardItem : Identifiable{
    
    var id = UUID()
    var nama : String
    var noHP : Int
    var pp : String
}


#Preview {
    MemberView()
}
