//
//  DetailHistory.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//

import SwiftUI

struct CardItem : Identifiable{
    var id = UUID()
    var pp : String
    var nama : String
    var area : String
}

struct DetailHistory: View {
    let items: [CardItem] = [
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
        CardItem(pp: "FotoProfil", nama: "Endang", area: "SML"),
    ]
    
    
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("Shift Pagi 06.00 - 15.00 WIB")
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])){
                        ForEach(items) {item in
                            ListMemberDetailHistory(item: item)
                        }
                    }
                Section(header: Text("Shift Siang 08.00 - 17.00 WIB")
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])){
                        ForEach(items) {item in
                            ListMemberDetailHistory(item: item)
                        }
                    }
                
            }
            .listStyle(.plain)
            .listRowSpacing(10)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Text("13 March - 30 March 2025")
                }
                ToolbarItem(placement: .confirmationAction) {
                    ShareLink(item: "Itu",message: Text("Share Schedule"))
                }
            }
            
            
            
            
        }
        
        
        
    }//var body
}

#Preview {
    DetailHistory()
}

struct ListMemberDetailHistory: View {
    
    let item: CardItem
    
    var body: some View {
                
                GroupBox{
                    HStack{
                        //pp
                        Image(item.pp)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:50, height:50)
                            .clipShape(Circle())
                            .shadow(radius:2)
                        
                        //nama & no.hp
                        HStack{
                            Text(item.nama)
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Text(item.area)
                                .padding(.trailing)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                .padding([.leading, .trailing])
    }
    
}


