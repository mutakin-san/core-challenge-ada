//
//  AssignmentCard.swift
//  ShinyShift
//
//  Created by Mutakin on 10/04/25.
//

import SwiftUI

struct AssignmentCard: View {
    let assignment: AssignmentRecord
    let areas: [String]
    let editMode: Bool
    let handleSwapArea: (_ newValue: String) -> Void
    
    var body: some View {
        HStack {
            Image(.profilePicture)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:50, height:50)
                .clipShape(Circle())
                .shadow(radius:2)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(assignment.member.name)
                    
                    Spacer()
                    
                    if editMode {
                        
                        Picker("Area", selection: Binding(
                            get: { assignment.area },
                            set: { newValue in
                                handleSwapArea(newValue)
                            }
                        )) {
                            ForEach(areas, id: \.self) { area in
                                Text(area)
                            }
                        }
                        .labelsHidden()
                        .frame(minWidth: 0, maxHeight: 30) // control height
                        .clipped()
                        .padding(0)
                    }
                    else {
                        Text(assignment.area)
                    }
                }
                Text(assignment.shiftType.description)
                    .font(.caption)
                
            }
        }

    }
}
