//
//  SidebarItem.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftUI

struct SidebarItem: View {
    let isActive: Bool
    let text: String
    let systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
            Text(text)
                .font(.system(size: 17))
                .fontWeight(.bold)
                .padding(.leading, 4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isActive ? .accent : .shadeGreen)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(.accent, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .foregroundStyle(isActive ? .white : .accent)
    }
}
