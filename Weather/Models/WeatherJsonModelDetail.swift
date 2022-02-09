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
///Wheather data
///

struct WeatherDetail : Decodable {
    var lat = Double()
    var lon = Double()
    var current = CurrentDetail(weather: [WeatherDetail1]())
    var daily = [DailyDetail1(weather: [WeatherDetail1]())]
    var alerts: [Alerts]?
    var minutely = [Minutely1]()
    var hourly = [Hourly1]()
}

struct CurrentDetail : Decodable {
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
    var rain: Rain?
    var snow: Snow?
    var weather: [WeatherDetail1]
}

struct WeatherDetail1 : Decodable {
    var id = Int()
    var main = String()
    var description = String()
    var icon = String()
}

struct DailyDetail1: Decodable {
    var dt = Int()
    var sunrise = Int()
    var sunset = Int()
    var moonrise = Int()
    var moonset = Int()

    ///
    /// Moon phase.
    ///     0 and 1 are 'new moon',
    ///     0.25 is 'first quarter moon',
    ///     0.5 is 'full moon' and
    ///     0.75 is 'last quarter moon'.
    ///

    var moon_phase = Double()

    var temp = Temp()
    var feels_like = FeelsLike()
    var pressure = Int()
    var humidity = Int()
    var dew_point = Double()
    var wind_speed = Double()
    var wind_gust: Double?
    var wind_deg = Int()
    var weather = [WeatherDetail1]()
    var clouds = Int()
    var pop = Double()
    var rain: Double?
    var snow: Double?
    var uvi = Double()
}


struct Temp: Decodable {
    var day = Double()
    var min = Double()
    var max  = Double()
    var night = Double()
    var eve = Double()
    var morn = Double()
}

struct FeelsLike: Decodable {
   var day = Double()
   var night = Double()
   var eve = Double()
   var morn = Double()
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

struct Minutely1: Decodable {
    var dt = Int()
    var precipitation = Double()
}

struct Hourly1: Decodable {
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
    var wind_gust: Double?
    var weather = [WeatherHourly]()
    var pop: Double
    var rain: RainHourly?
    var snow: SnowHourly?
}

struct WeatherHourly: Decodable {
    var id = Int()
    var main = String()
    var description = String()
    var icon = String()
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

// MARK: - Weather5Days
struct WeatherDetail5Days: Codable {
    var cod = String()
    var message = Int()
    var cnt = Int()
    var list = [List1]()
    var city = City()
}

//// MARK: - City
struct City: Codable {
    var id = Int()
    var name = String()
    var coord = Coord()
    var country = String()
    var population = Int()
    var timezone = Int()
    var sunrise = Int()
    var sunset = Int()
}

// MARK: - Coord
struct Coord: Codable {
    var lat = Double()
    var lon = Double()
}

// MARK: - List
struct List1: Codable {
    var dt = Int()
    var main = MainClass()
    var weather = [Weather5]()
    var clouds = Clouds()
    var wind = Wind1()
    var visibility = Int()
    var pop = Double()
    var rain: Rain5?
    var sys = Sys()
    var dtTxt = String()
    let snow: Rain5?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
        case snow
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all = Int()
}

// MARK: - MainClass
struct MainClass: Codable {
    var temp = Double()
    var feelsLike = Double()
    var tempMin = Double()
    var tempMax = Double()
    var pressure = Int()
    var seaLevel = Int()
    var grndLevel = Int()
    var humidity = Int()
    var tempKf = Double()

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain5
struct Rain5: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    var pod = String()
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather5Days
struct Weather5: Codable {
    var id = Int()
    var main: MainEnum
    var weatherDescription = String()
    var icon = String()

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

// MARK: - Wind
struct Wind1: Codable {
    var speed = Double()
    var deg = Int()
    var gust = Double()
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// MARK: - WeatherCityCoordinates
struct WeatherCityCoordinates: Codable {
    var coord = Coord1()
    var weather = [Weather1]()
    var base = String()
    var main = Main()
    var visibility = Int()
    var wind = Wind2()
    var clouds = Clouds1()
    var dt = Int()
    var sys = Sys1()
    var timezone = Int()
    var id = Int()
    var name = String()
    var cod = Int()
}

// MARK: - Clouds1
struct Clouds1: Codable {
    var all = Int()
}

// MARK: - Coord1
struct Coord1: Codable {
    var lon = Double()
    var lat = Double()
}

// MARK: - Main
struct Main: Codable {
    var temp = Double()
    var feelsLike = Double()
    var tempMin = Double()
    var tempMax = Double()
    var pressure = Int()
    var humidity = Int()

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys1
struct Sys1: Codable {
    var type = Int()
    var id = Int()
    var country = String()
    var sunrise = Int()
    var sunset = Int()
}

// MARK: - Weather
struct Weather1: Codable {
    var id = Int()
    var main = String()
    var weatherDescription = String()
    var icon = String()

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind2
struct Wind2: Codable {
    var speed = Double()
    var deg = Int()
}
