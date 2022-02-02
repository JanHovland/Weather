//
//  CurrentRecord.swift
//  Weather
//
//  Created by Jan Hovland on 29/03/2021.
//

import Foundation

struct CurrentRecord {
    var dt = Int()
    var sunrise = Int()
    var sunset = Int()
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
    var wind_gust: Double?
    var rain_the1h: Double?
    var snow_the1h: Double?
    var weather_id = Int()
    var weather_main = String()
    var weather_description = String()
    var weather_icon = String()
}
