//
//  WeatherServiceDetail.swift
//  Weather
//
//  Created by Jan Hovland on 21/03/2021.
//

import Foundation

class WeatherServiceDetail {
    
    func getWeatherDetail(lat: Double, lon: Double, completion: @escaping (Result<WeatherJsonDetail?, NetworkError>) -> Void) {
       
        guard  let url = URL.urlForWeatherDetail(lat: lat, lon: lon) else {
            return completion(.failure(.check_the_Url))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponseDetail = try? JSONDecoder().decode(WeatherJsonDetail.self, from: data)
            if let weatherResponseDetail = weatherResponseDetail {
                completion(.success(weatherResponseDetail))
            } else {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
    
}

