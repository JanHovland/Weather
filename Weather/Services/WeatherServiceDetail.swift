//
//  WeatherServiceDetail.swift
//  Weather
//
//  Created by Jan Hovland on 21/03/2021.
//

import Foundation
import SwiftUI

class WeatherServiceDetail: ObservableObject {
    @Published var weatherDetail = WeatherDetail()
    func getWeatherDetail(_ lat: Double, _ lon: Double) async -> (LocalizedStringKey, WeatherDetail) {
        var err: LocalizedStringKey = ""
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&&lang=no&units=metric&appid=" + apiKey)!
        
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            weatherDetail = try JSONDecoder().decode(WeatherDetail.self, from: data)
        }
        catch {
            err = LocalizedStringKey(error.localizedDescription)
            print(err)
        }
        return (err, weatherDetail)
    }
}







