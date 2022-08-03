//
//  WeatherServiceCityCoordinatee.swift
//  Weather
//
//  Created by Jan Hovland on 09/02/2022.
//

import Foundation
import SwiftUI

// https://www.latlong.net/convert-address-to-lat-long.html
// https://www.geoapify.com/pricing
// https://apidocs.geoapify.com/docs/geocoding/forward-geocoding/#about

class WeatherServiceCityCoordinates: ObservableObject {
    @Published var weatherCityCoordinates = WeatherCityCoordinates()
    func CityCoordinates(_ city: String) async -> (LocalizedStringKey, WeatherCityCoordinates) {
        var err: LocalizedStringKey = ""
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(TranslateCity(str: city))&lang=no&units=metric&appid=" + apiKey)!
        print(url as Any)
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            weatherCityCoordinates = try JSONDecoder().decode(WeatherCityCoordinates.self, from: data)
        }
        catch {
            err = LocalizedStringKey(error.localizedDescription)
        }
        return (err, weatherCityCoordinates)
    }
}
