//
//  HistoryView.swift
//  CleanPlot
//
//  Created by Zaidan Akmal on 27/03/25.
//


import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                Text("History")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                    List([1,2,3,4,5,6,7,8,9,10], id: \.self) {
                        item in
                        
                
                        NavigationLink {
                         
                        } label: {
                            
                            
                            HStack {
                                Text("17 Maret - 30 Maret")
                                Spacer()
                                
                                
                            }
                        }
                    }

            }
        }
    }
}

#Preview {
    HistoryView()
}
