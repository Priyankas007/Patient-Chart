//
//  Medication.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import Foundation

struct Medication : Equatable {
    let datePrescribed: Date
    let name: String
    var dose: String
    let route: String
    var frequency: Int
    var duration: Int
    
    var isCompleted: Bool {
        if let endDate = Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed)  {
            return Date() > endDate
        } else {
            return false
        }
    }
}


