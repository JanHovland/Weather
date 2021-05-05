//
//  WeatherJsonModel.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//

import Foundation

///
/// https://app.quicktype.io
///

/// This file was generated from JSON Schema using quicktype, do not modify it directly.
/// To parse the JSON, add this file to your project and do:
///
///   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
///

struct WeatherJsonModel: Decodable {
    let weatherJsonModelInfo : WeatherJsonModelInfo
}

struct WeatherJsonModelInfo : Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind1
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Wind1
struct Wind1: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double?
}




