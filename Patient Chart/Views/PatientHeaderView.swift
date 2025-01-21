//
//  PatientHeaderView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

// Patient Header with Image and Name
struct PatientHeaderView: View {
    let patient: Patient
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .accessibilityHidden(true)
            
            Text("\(patient.lastName), \(patient.firstName)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .accessibilityLabel("Patient name: \(patient.lastName), \(patient.firstName)")
        }
    }
}
