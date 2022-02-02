//
//  WeatherSErviceCoordinate.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case check_the_Url
    case noData
    case decodingError
}

@MainActor
class WeatherServiceCoordinate: ObservableObject {
    
    
    @Published var weatherCoordinates = WeatherCoordinates()
    func getCoordinates(_ city: String) async -> (LocalizedStringKey, WeatherCoordinates) {
        var err: LocalizedStringKey = ""
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(TranslateCity(str: city))&lang=no&units=metric&appid=" + apiKey)!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            weatherCoordinates = try JSONDecoder().decode(WeatherCoordinates.self, from: data)
        }
        catch {
            err = LocalizedStringKey(error.localizedDescription)
        }
        return (err, weatherCoordinates)
    }
}
