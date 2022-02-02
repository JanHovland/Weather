//
//  Precipitation.swift
//  Weather
//
//  Created by Jan Hovland on 22/04/2021.,0
//

import SwiftUI

struct Precipitation: Identifiable {
    var id = UUID()
    var maxRain60Minutes = Double()
    var rain60Minutes = [Double]()
    var minutesUntilRainStarts = Int()
    var minutesUntilRainStops = Int()
    var hoursUntilRainStarts = Int()
    var hoursUntilRainStops = Int()
    var maxRain8Hours = Double()
    var rain8Hours = [Double]()
    var maxTemperature = Double()
}

