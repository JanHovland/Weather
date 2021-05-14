//
//  HourlyRecord.swift
//  Weather
//
//  Created by Jan Hovland on 31/03/2021.
//

import Foundation

struct HourlyRecord: Identifiable {
    var id = UUID()
    var sectionHeading: String
    var sunrise: String
    var sunset: String
    var moon_phase: Double
    var dt: Int
    var numberHourdataFirstDay: Int
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var uvi: Double
    var clouds: Int
    var visibility: Int
    var wind_speed: Double
    var wind_deg: Int
    var wind_gust: Double
    var weather_id: Int
    var weather_main: String
    var weather_description: String
    var weather_icon: String
    var pop: Double
    var rain: Double?
    var snow: Double?
}
