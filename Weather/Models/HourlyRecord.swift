//
//  HourlyRecord.swift
//  Weather
//
//  Created by Jan Hovland on 31/03/2021.
//

import Foundation

struct HourlyRecord: Identifiable {
    var id = UUID()
    var sectionHeader = String()
    var sectionFooter = String()
    var indexHourlyData = Int()
    var sunrise = String()
    var sunset = String()
    var moon_phase = Double()
    var dt = Int()
    var temp = Double()
    var feels_like = Double()
    var pressure = Int()
    var humidity = Int()
    var dew_point = Double()
    var uvi = Double()
    var clouds = Int()
    var visibility = Int()
    var wind_speed = Double()
    var wind_deg = Int()
    var wind_gust = Double()
    var weather_id = Int()
    var weather_main = String()
    var weather_description = String()
    var weather_icon = String()
    var pop = Double()
    var rain: Double?
    var snow: Double?
}

class ImageInfo: ObservableObject {
    
    @Published var sectionHeader0 : String = ""
    @Published var sectionHeader1 : String = ""
    @Published var sectionHeader2 : String = ""

    @Published var sectionFooter0 : String = ""
    @Published var sectionFooter1 : String = ""
    @Published var sectionFooter2 : String = ""
    
    @Published var moonPhase0: Double = 0.00
    @Published var moonPhase1: Double = 0.00
    @Published var moonPhase2: Double = 0.00

    @Published var sunRise0: String = ""
    @Published var sunRise1: String = ""
    @Published var sunRise2: String = ""

    @Published var sunSet0: String = ""
    @Published var sunSet1: String = ""
    @Published var sunSet2: String = ""

    @Published var compressed0: Bool = true
    @Published var compressed1: Bool = true
    @Published var compressed2: Bool = true

}
 
