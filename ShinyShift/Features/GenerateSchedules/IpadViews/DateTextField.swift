//
//  DateTextField.swift
//  ShinyShift
//
//  Created by Mutakin on 14/05/25.
//

import SwiftUI

struct DateTextField: View {
    var title: String
    @Binding var date: Date
    @State private var showPicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)

            // TextField look-alike
            Button(action: {
                showPicker.toggle()
            }) {
                HStack {
                    Text(formattedDate)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).stroke(.accent))
            }
            .sheet(isPresented: $showPicker) {
                VStack {
                    DatePicker(
                        "Select Date",
                        selection: $date,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .padding()

                    Button("Done") {
                        showPicker = false
                    }
                    .padding()
                }
            }
        }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
}
