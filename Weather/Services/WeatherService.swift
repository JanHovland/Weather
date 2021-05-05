//
//  WeatherService.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//

import Foundation

enum NetworkError: Error {
    case check_the_Url
    case noData
    case decodingError
}

class WeatherService {
    
    func getWeather(city: String, completion: @escaping (Result<WeatherJsonModelInfo?, NetworkError>) -> Void) {
        guard  let url = URL.urlForWeather(city: city) else {
            return completion(.failure(.check_the_Url))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherJsonModelInfo.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse))
            } else {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
    
}
