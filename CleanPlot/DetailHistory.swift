//
//  DetailHistory.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//

import SwiftUI

struct DetailHistory: View {
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Text("17 March - 30 March 2025")
                        .font(.headline)
                        .padding(.leading)
                    Spacer()
                    ShareLink(item: "Jadwal 17 Maret - 30 Maret 2025.pdf") {
                        Image(systemName:"square.and.arrow.up")
                            .foregroundColor(.blue)
                            .padding(.trailing)
                            .imageScale(.large)
                    }
                }
                Divider()
                
                ListMemberDetailHistory()
                
                
                           
            }
        }.navigationTitle("tes")
        
        
    }
}

#Preview {
    DetailHistory()
}
