//
//  ScheduleEmptyView.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftUI

struct ScheduleEmptyView: View {
    @Binding var selection: ScheduleModel?
    @State private var showAddScheduleSheet: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 90)
                .foregroundStyle(.secondary)
                .padding(.bottom, 10)
            Text("No Schedules")
                .font(.title3)
                .bold()
                .foregroundStyle(.secondary)
            Text("Create area plotting schedule for your team")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .foregroundStyle(.secondary)
            Button {
                showAddScheduleSheet = true
            } label: {
                Label("New Schedule", systemImage: "plus.square")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .bold()
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .popover(isPresented: $showAddScheduleSheet) {
                CreateScheduleView { schedule in
                    selection = schedule
                }
            }
        }
        .padding(.horizontal, 24)
    }
}
