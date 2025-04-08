//
//  MemberCard.swift
//  CleanPlot
//
//  Created by Mutakin on 26/03/25.
//

import SwiftUI


struct MemberCard: View {
    var item: Member
    @State var isActive = false
    @Environment(\.modelContext) var modelContext

    
    var body: some View {
        
        HStack{
            
            Image(item.imagePath)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:50, height:50)
                .clipShape(Circle())
            
            VStack{
                Text(item.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(item.phone)")
                    .font(.system(size: 10))
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
            }
            Spacer()
            Toggle("Status", isOn: $isActive)
                .onChange(of: isActive) { oldValue, newValue in
                    print(newValue)
                    item.status = newValue
                    
                    do {
                        try modelContext.save()
                    } catch {
                        print("Error saving assignments: \(error)")
                    }
                    
                }
        }
        .onAppear {
            isActive = item.status
        }
    }
}

#Preview {
    MemberCard(item: Member(imagePath: "ProfilePicture", name: "Endang", phone: "+628578483827", address: "Bandung"))
}
