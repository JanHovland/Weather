//
//  WeatherJsonModelDetail.swift
//  Weather
//
//  Created by Jan Hovland on 21/03/2021.
//

import Foundation


///
/// https://app.quicktype.io
///
/// Her settes det opp modellen for å finne de aktuelle verdiene fra Json
///
/// Det er her det kommer "decodingError" !!!!! 
///
/// Decoding error kommer:
///     derom det er lagt inn feil type f.eks Int istedet for Double
///     et av feltene i json ikke finnes fordi det ikke er noen verdi
///     et av feltene ikke kommer, ref var alerts: [Alerts]? :  Handlingen kunne ikke fullføres. (Weather.NetworkError-feil 2) sett dette til optional
///

///
/// Topp nivå
///

struct WeatherJsonDetail : Decodable {
    var lat: Double
    var lon: Double
    var current: CurrentJsonDetail
    var daily: [DailyJsonDetail1]
    var alerts: [Alerts]?           // Det er ikke sikkert at Alerts alltid kommer, må settes til optional
    var minutely: [Minutely]
    var hourly: [Hourly]
}

///
/// current struct
///

struct CurrentJsonDetail : Decodable {
    var dt: Int
    var sunrise: Int
    var sunset: Int
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
    var wind_gust: Double?
    var rain: Rain?
    var snow: Snow?
    var weather: [WeatherJsonDetail1]
}

///
/// current struct sitt weather struct
///

struct WeatherJsonDetail1 : Decodable {
    var id: Int
    var main: String
    
    var description: String
    var icon: String
}

///
/// daily struct
///

struct DailyJsonDetail1: Decodable {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var moonrise: Int
    var moonset: Int
    
    ///
    /// Moon phase.
    ///     0 and 1 are 'new moon',    
    ///     0.25 is 'first quarter moon',
    ///     0.5 is 'full moon' and
    ///     0.75 is 'last quarter moon'.
    ///
    
    var moon_phase: Double
    
    var temp: Temp
    var feels_like: FeelsLike
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var wind_speed: Double
    var wind_gust: Double?
    var wind_deg: Int
    var weather: [WeatherJsonDetail1]
    var clouds: Int
    var pop: Double
    var rain: Double?
    var snow: Double?
    var uvi: Double
}

///
/// temp struct
///

struct Temp: Decodable {
    var day, min, max, night: Double
    var eve, morn: Double
}

///
/// FeelsLike struct
///

struct FeelsLike: Decodable {
   var day: Double
   var night: Double
   var eve: Double
   var morn: Double
}

struct Rain: Decodable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Snow: Decodable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Alerts: Decodable {
   var sender_name: String?
   var event: String?
   var start: Int?
   var end: Int?
   var description: String?
}

struct Minutely: Decodable {
    var dt: Int
    var precipitation: Double
}

struct Hourly: Decodable {
    var dt: Int
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
    var wind_gust: Double?
    var weather: [WeatherHourly]
    var pop: Double
    var rain: RainHourly?
    var snow: SnowHourly?
}

struct WeatherHourly: Decodable {
    var id: Int
    var main: String
    var description : String
    var icon: String
}

struct RainHourly: Decodable {
    var the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct SnowHourly: Decodable {
    var the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

