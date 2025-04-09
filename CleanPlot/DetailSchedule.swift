//
//  DetailSchedule.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 08/04/25.
//

import SwiftUI

struct DetailSchedule : View {
    
    @State private var showSheet = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Button("Show Sheet") {
                    showSheet = true
                }
                .sheet(isPresented: $showSheet) {
                    ScheduleData()
                }
                
            }
        }
    }//varbody
    
    struct ScheduleData : View {
        
        @Environment(\.presentationMode) var presentationMode
        @State private var isEditMode: EditMode = .inactive
        
        var body: some View {
            NavigationView{
                VStack (alignment: .leading){
                    HStack(spacing: -8){
                        VStack (alignment: .leading){
                            Text("Start Date")
                                .padding(.leading)
                            
                            HStack {
                                Image(systemName: "calendar")
                                    .imageScale(.medium)
                                    .padding(.leading)
                                    .foregroundStyle(.gray)
                                Spacer().frame(width: 24)
                                Text("April 8, 2024")
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width / 2.5, height: 56)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            ).padding(.horizontal)
                        }
                        
                        
                        VStack(alignment: .leading){
                            Text("End Date")
                                .padding(.leading)
                            HStack {
                                Image(systemName: "calendar")
                                    .imageScale(.medium)
                                    .padding(.leading)
                                    .foregroundStyle(.gray)
                                Spacer().frame(width: 24)
                                Text("April 8, 2024")
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width / 2.5, height: 56)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            ).padding(.horizontal)
                        }
                    }
                    Divider()
                        .frame(width: 350, height: 24)
                        .padding(.horizontal)
                    
                    ShiftView()
                    
                    
                    
                }.navigationTitle("Schedule")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading){
                            Button(isEditMode.isEditing ? "Done" : "Edit") {
                                isEditMode = isEditMode.isEditing ? .inactive : .active
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing){
                            Button("Done") {
                                presentationMode.wrappedValue.dismiss()
                            }.padding()
                        }
                    }
            }
            .environment(\.editMode, $isEditMode)
            
        }
    }
    
    
}


#Preview {
    DetailSchedule()
}
