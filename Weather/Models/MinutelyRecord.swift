//
//  MinutelyRecord.swift
//  Weather
//
//  Created by Jan Hovland on 31/03/2021.
//

import Foundation

struct MinutelyRecord: Identifiable {
    var id = UUID()
    var dt: Int
    var precipitation: Double
}
 
