//
//  WeatherServiceDetail5Days.swift
//  Weather
//
//  Created by Jan Hovland on 22/12/2021.
//

import SwiftUI

@MainActor
class WeatherData5Days: ObservableObject {
    @Published var weatherDetail5Days = WeatherDetail5Days()
    func getWeather5Days(_ lat: Double, _ lon: Double) async -> (LocalizedStringKey, WeatherDetail5Days) {
        var err: LocalizedStringKey = ""
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&lang=no&units=metric&appid" + apiKey)!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            weatherDetail5Days = try JSONDecoder().decode(WeatherDetail5Days.self, from: data)
        }
        catch {
            err = LocalizedStringKey(error.localizedDescription)
            print(err)
        }
        return (err, weatherDetail5Days)
    }
}

