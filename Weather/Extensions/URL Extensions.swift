//
//  URL rExtensions.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//
//

import Foundation

extension URL {
    
    static func urlForWeather(city: String) -> URL? {
        ///
        /// Konverterer city
        ///
        let city = TranslateCity(str: city)
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&lang=no&units=metric&appid=" + apiKey) else {
            return nil
        }
        print(url)
        return url
    }
    
    static func urlForWeatherDetail(lat: Double, lon: Double) -> URL? {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&lang=no&units=metric&appid=" + apiKey) else {
            return nil
        }
        print(url)
        return url
    }

}
