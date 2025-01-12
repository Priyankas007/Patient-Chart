//
//  BlootType.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import Foundation

enum BloodType: String {
    case APos = "A+"
    case ANeg = "A-"
    case BPos = "B+"
    case BNeg = "B-"
    case OPos = "O+"
    case ONeg = "O-"
    case ABPos = "AB+"
    case ABNeg = "AB-"
    
    static func possibleDonors(for type: BloodType) -> [BloodType] {
        switch type {
        case .APos: return [.APos, .ANeg, .OPos, .ONeg]
        case .ANeg: return [.ANeg, .ONeg]
        case .BPos: return [.BPos, .BNeg, .OPos, .ONeg]
        case .BNeg: return [.BNeg, .ONeg]
        case .OPos: return [.OPos, .ONeg]
        case .ONeg: return [.ONeg]
        case .ABPos: return [.APos, .ANeg, .BPos, .BNeg, .OPos, .ONeg, .ABPos, .ABNeg]
        case .ABNeg: return [.ABNeg, .ANeg, .BNeg, .ONeg]
        }
    }
}
