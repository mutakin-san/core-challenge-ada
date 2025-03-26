//
//  AddMemberView.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//
import SwiftUI
import UIKit

struct AddMemberView: View {
    @Binding var isSheetPresented: Bool
    @Binding var members: [MemberModel]

    @State private var name = ""
    @State private var address = ""
    @State private var phoneNumber = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @State private var showSuccessMessage: Bool = false
    
    var body: some View {
        VStack {
            //header
            HStack {
                Button("Cancel") {
                    isSheetPresented = false
                }
                .padding(.leading)
                
                Text("Add Member")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding()
                
                Button("Save") {
                    members.append(MemberModel(imagePath: "ProfilePicture", name: name, phone: phoneNumber, address: address))
                    showSuccessMessage = true
                }
                .alert("Success", isPresented: $showSuccessMessage, actions: {
                    Button("Ok"){
                        isSheetPresented = false
                    }
                }, message: {
                    Text("Member Successfully Saved!")
                })
                .padding(.trailing)
            }
            .frame(maxHeight: 30)
            .padding(.top)
            
            //Profile Picture
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 180, height: 180)
                
                // White silhouette
                
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
            }
            
            Button(action: {
                showImagePicker = true
            }) {
                Text("Add Photo")
                    .bold()
                    .foregroundColor(.blue)
                    .frame(width: 150, height: 50)
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(Capsule())
                    .padding()
                
                
            }.sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            
            
            
            
            // Text input fields
            List {
                Section {
                    TextField("Name", text: $name)
                        
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                    
                    TextField("Address", text: $address)
                }
                .listRowBackground(Color.secondary.opacity(0.1))
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            
        }
    }
}
