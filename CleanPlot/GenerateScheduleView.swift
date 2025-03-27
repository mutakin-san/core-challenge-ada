//
//  GenerateScheduleView.swift
//  CleanPlot
//
//  Created by Zaidan Akmal on 27/03/25.
//


import SwiftUI

struct GenerateScheduleView: View {
    @State var noSchedule: Bool = false
    
    func generate() {
        noSchedule.toggle()
    }
    var body: some View {
        NavigationStack {
            VStack {
                
                if noSchedule {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Halo, Subur!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Let's create the schedule for your team")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    Text("Tidak ada jadwal")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                }
                
                else {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Halo, Subur!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Let's create the schedule for your team")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .font(.subheadline)
                        
                        
                        HStack {
                            Text("17 - 30 Maret 2025")
                            
                            Spacer()
                            
                            ShareLink(item: /*@START_MENU_TOKEN@*/URL(string: "https://developer.apple.com/xcode/swiftui")!/*@END_MENU_TOKEN@*/)
                        }
                        .padding()
                        
                        
                        List([1,2,3,4,5,6,7,8,9,10], id: \.self) {
                            item in
                            
                            HStack {
                                Image(.manPicture)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Ole Romeny")
                                        
                                        Spacer()
                                        Text("SML")
                                        
                                    }
                                    Text("Shift Pagi")
                                        .font(.caption)
                                    
                                }
                            }
                            
                        }
                        .listRowSpacing(10)
                        
                    }
                    Spacer()
                    Spacer()
                    
                }
                
                Button(action: generate) {
                    ZStack {
                        Rectangle()
                            .frame(height: 55.0)
                            .padding()
                            .foregroundStyle(.blue)
                        Text("Generate")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                }
                
            }
        }
    }
}


#Preview {
    GenerateScheduleView(noSchedule: false)
}
