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
