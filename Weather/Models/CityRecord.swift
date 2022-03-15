//
//  Place.swift
//  Weather
//
//  Created by Jan Hovland on 13/03/2021.
//

import SwiftUI
import CloudKit

struct CityRecord: Identifiable, Sendable {
    var id = UUID()
    var recordID: CKRecord.ID?
    var lat: Double = 0.0             // latitude  = breddegrad
    var lon: Double = 0.0             // longitude = lengdegrad
    var city: String = ""
}

extension UUID: @unchecked Sendable {}
extension CKRecord.ID: @unchecked Sendable {}
extension NSPredicate: @unchecked Sendable {}
