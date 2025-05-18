//
//  DetailScheduleGrid.swift
//  ShinyShift
//
//  Created by Mutakin on 16/05/25.
//

import SwiftUI

struct DetailScheduleGrid: View {
    let shiftName: String
    let shiftTime: String
    let assignments: [AssignmentModel]
    let onSwap: (Member, AssignmentModel) -> Void
    let isEditMode: Bool

    var members: [Member] {
        assignments.compactMap(\.member)
    }

    // Add computed property for dynamic grid columns
    private var gridColumns: [GridItem] {
        let minWidth: CGFloat = 200  // Minimum width for each card
        let maxWidth: CGFloat = 300  // Maximum width for each card
        return [
            GridItem(.adaptive(minimum: minWidth, maximum: maxWidth))
        ]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(shiftName)
                    .font(.title2)
                Spacer()
                Text(shiftTime)
                    .font(.title2)
            }
            .padding(.top)
            
            
            ScrollView {
                LazyVGrid(
                    columns: gridColumns
                ) {
                    ForEach(assignments) { assignment in
                        GridCard(
                            assignment: assignment,
                            onSwap: onSwap,
                            isEditMode: isEditMode,
                            members: members
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    DetailScheduleGrid(
        shiftName: "Morning Shift", shiftTime: "06:00 - 15:00", assignments: [],
        onSwap: { _, _ in }, isEditMode: false)
}

struct GridCard: View {
    let assignment: AssignmentModel
    let onSwap: (Member, AssignmentModel) -> Void
    let isEditMode: Bool
    let members: [Member]

    var body: some View {
        ZStack {
            Image("AreaPicture")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 12) {
                Text("\(assignment.area)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Assigned to")
                        .font(.body)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    if isEditMode {
                        Picker(
                            "Name",
                            selection: Binding(
                                get: { assignment.member },
                                set: { newValue in
                                    onSwap(newValue, assignment)
                                }
                            )
                        ) {
                            ForEach(members, id: \.persistentModelID) { member in
                                Text(member.name).tag(member)
                            }
                        }
                        .background(.white)
                        .labelsHidden()
                        .cornerRadius(8)
                    } else {
                        HStack(spacing: 8) {
                            Image(assignment.member.imagePath)
                                .resizable()
                                .frame(width: 28, height: 28)
                                .clipShape(Circle())
                            Text("\(assignment.member.name)")
                                .font(.body)
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .frame(minHeight: 180)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
