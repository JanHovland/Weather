//
//  DailyRecord.swift
//  Weather
//
//  Created by Jan Hovland on 29/03/2021.
//

import Foundation

struct DailyRecord: Identifiable {
    var id = UUID()
    var index = Int()
    var dt = Int()
    var sunrise = Int()
    var sunset = Int()
    var moonrise = Int()
    var moonset = Int()
    var moon_phase = Double()
    var temp_day = Double()
    var temp_min = Double()
    var temp_max = Double()
    var temp_night = Double()
    var temp_eve = Double()
    var temp_morn = Double()
    var feels_like_day = Double()
    var feels_like_night = Double()
    var feels_like_eve = Double()
    var feels_like_morn = Double()
    var pressure = Int()
    var humidity = Int()
    var dew_point = Double()
    var wind_speed = Double()
    var wind_gust: Double?
    var wind_deg = Int()
    var weather_id = Int()
    var weather_main = String()
    var weather_description = String()
    var weather_icon = String()
    var clouds = Int()
    var pop = Double()          /// Probability of precipitation
    var rain_the1h: Double?     /// dette elementet kan mangle
    var snow_the1h: Double?
    var uvi = Double()
}
