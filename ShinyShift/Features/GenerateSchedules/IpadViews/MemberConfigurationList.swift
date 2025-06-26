//
//  MemberConfigurationList.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftData
import SwiftUI

struct MemberConfigurationList: View {
    @Query var members: [Member]
        
    var body: some View {
        if members.isEmpty {
            EmptyMemberView()
                .padding()
        } else {
            LazyVStack {
                ForEach(members, id: \.id) { member in
                    HStack {
                        Image(member.imagePath)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing, 5)
                        Text(member.name)
                        Spacer()
                        Toggle(
                            "",
                            isOn: Binding(
                                get: { member.status },
                                set: { newValue in
                                    member.status = newValue
                                }
                            )
                        )
                        .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.accent, lineWidth: 1)
                    )
                }
            }
        }
    }
}


struct EmptyMemberView: View {
    var body: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 90)
                .foregroundStyle(.secondary)
                .padding(.bottom, 10)
            Text("No Member Found")
                .font(.title3)
                .bold()
                .foregroundStyle(.secondary)
            Text("Make sure you have added some member")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
    }
}

#Preview {
    MemberConfigurationList()
}
