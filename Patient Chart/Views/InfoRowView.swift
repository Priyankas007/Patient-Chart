//
//  SwiftUIView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

// Reusable Info Row Component
struct InfoRow: View {
    let label: String
    let value: String
    var unit: String?
    
    var body: some View {
        Text("\(label): \(value)\(unit != nil ? " \(unit!)" : "")")
            .font(.subheadline)
            .accessibilityLabel("\(label): \(value)\(unit != nil ? " \(unit!)" : "")")
    }
}

#Preview {
    //InfoRowView()
}
