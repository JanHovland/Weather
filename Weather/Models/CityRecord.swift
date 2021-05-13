//
//  Place.swift
//  Weather
//
//  Created by Jan Hovland on 13/03/2021.
//

import SwiftUI
import CloudKit

struct CityRecord: Identifiable {
    var id = UUID()
    var recordID: CKRecord.ID?
    var lat: Double             // latitude  = breddegrad
    var lon: Double             // longitude = lengdegrad
    var city: String
    var icon: String
    var temp: Double
    var description: String
    var deg: Int
    var wind_speed: Double
    var wind_gust: Double?
}
