//
//  AddMemberView.swift
//  CleanPlot
//
//  Created by Frewin Saputra on 26/03/25.
//
import SwiftUI
import UIKit
import SwiftData

struct AddMemberView: View {
    
    let member: Member?
    private var editorTitle: String {
        member == nil ? "Add Member" : "Edit Member"
    }
    private var photoTitle: String {
        member == nil ? "Add Photo" : "Edit Photo"
    }
    
    
    @State private var name = ""
    @State private var address = ""
    @State private var phoneNumber = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @State private var showSuccessMessage: Bool = false
    @State private var showAlert: Bool = false
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .clipShape(.circle)
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                        .foregroundColor(.white)
                        .frame(maxWidth: 100, maxHeight: 100)
                    
                        .background(.gray)
                        .clipShape(.circle)
                    
                }
                
                
                Button(action: {
                    showImagePicker = true
                }) {
                    Text(photoTitle)
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
                Form {
                    Section {
                        TextField("Name", text: $name)
                        
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                        
                        TextField("Address", text: $address)
                    }
                    .listRowBackground(Color.secondary.opacity(0.1))
                }
                .scrollContentBackground(.hidden)
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                        }
                    }
                    .alert("Gagal", isPresented: $showAlert) {
                        Button("Ok") {
                            showAlert = false
                        }
                    } message: {
                        Text("Silahkan isi semua data!")
                    }
                    
                    
                }
            }
            .onAppear {
                if let member {
                    name = member.name
                    phoneNumber = member.phone
                    address = member.phone
                }
            }
        }
        
    }
    
    
    private func save() {
        if(name.isEmpty || phoneNumber.isEmpty || address.isEmpty) {
            showAlert = true
            return
        }
        if let member {
            member.name = name
            member.phone = phoneNumber
            member.address = address
        } else {
            let newMember = Member(name: name, phone: phoneNumber, address: address)
            
            modelContext.insert(newMember)
        }
        dismiss()
        
    }
}


#Preview {
    AddMemberView(member: nil)
}
