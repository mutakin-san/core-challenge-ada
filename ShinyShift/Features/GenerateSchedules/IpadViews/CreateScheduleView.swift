//
//  CreateScheduleView.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftData
import SwiftUI

struct CreateScheduleView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @Environment(\.dismiss) private var dismiss: DismissAction

    var body: some View {
        VStack(spacing: 0) {
            // Fixed Header
            HStack {
                Text("Create New Schedule")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button("Close", systemImage: "multiply") {
                    dismiss()
                }
                .font(.title2)
                .fontWeight(.bold)
                .labelStyle(.iconOnly)
            }
            .padding()

            Divider()

            // Scrollable content
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    DateTextField(title: "Start Date", date: $startDate)
                    DateTextField(title: "End Date", date: $endDate)

                    // Members
                    Text("Select Members")
                        .fontWeight(.semibold)

                    MemberConfigurationList()
                }
                .padding()
            }

            Divider()

            // Fixed Button
            Button(action: {
                // Generate schedule logic
            }) {
                Text("Generate Schedule")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
        .frame(minWidth: 420)
    }
}

#Preview {
    CreateScheduleView()
}
