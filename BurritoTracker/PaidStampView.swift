//
//  PaidStampView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/24/24.
//

import SwiftUI

struct PaidStampView: View {
    var body: some View {
        Text("🌯 PAID")
            .font(.system(size: 36, weight: .bold))
            .foregroundColor(.red)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 4)
            )
            .rotationEffect(.degrees(-15))
    }
}

#Preview {
    PaidStampView()
}
