//
//  SuccessDialogView.swift
//  ShinyShift
//
//  Created by Mutakin on 15/05/25.
//

import SwiftUI

struct SuccessDialogView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 48))
                .foregroundColor(.accent)
                .padding()
            Text("Success")
                .font(.headline)
            Text("Successfully generate schedule.")
                .font(.body)
                .padding(.bottom, 16)
            Button(action: {
                dismiss()
            }) {
                Text("OK")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .background(.accent)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

#Preview {
    SuccessDialogView()
}
