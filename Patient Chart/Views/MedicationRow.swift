//
//  MedicationRow.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

struct MedicationRow: View {
    @Binding var medication: Medication
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(medication.name)")
                .font(.headline)
            Text("Dose: \(medication.dose), Route: \(medication.route)")
                .font(.subheadline)
            Text("Frequency: \(medication.frequency) times/day, Duration: \(medication.duration) days")
                .font(.subheadline)
            Text("Prescribed on: \(medication.datePrescribed.formatted(date: .abbreviated, time: .omitted)), Days Remaining: \(daysRemaining(from: medication.datePrescribed, duration: medication.duration))")
                .font(.subheadline)
        }
        .accessibilityLabel("Medication \(medication.name), dose \(medication.dose) mg, route \(medication.route), frequency \(medication.frequency) times per day, duration \(medication.duration) days.")
    }
    
    func daysRemaining(from datePrescribed: Date, duration: Int) -> Int {
        let calendar = Calendar.current
        if let endDate = calendar.date(byAdding: .day, value: duration, to: datePrescribed) {
            let remainingDays = calendar.dateComponents([.day], from: Date(), to: endDate).day ?? 0
            return max(remainingDays, 0) // Ensure no negative days
        }
        return 0
    }
}



#Preview {
    //MedicationRow()
}
