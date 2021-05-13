//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//

import Foundation
import CloudKit

/// Option Binding:
/// This is one of the safe ways to read optional and in case of nil we just provide a default value.
/// var studentCount: Int?
/// print(studentCount ?? 0)
///
/// wind_gust: (weatherInfo?.wind.gust) ?? 0.00)
///

class WeatherViewModel: ObservableObject {
    
    @Published private var weatherJsonModelInfo: WeatherJsonModelInfo?
    
    /// Temperaturen er i Kelvin
    var temp: Double {
        guard let temp = weatherJsonModelInfo?.main.temp else {
            return 0.0
        }
        return temp
    }
    
    /// Icon er en String
    var icon: String {
        guard let icon = weatherJsonModelInfo?.weather[0].icon else {
            return ""
        }
        return icon
    }
    
    /// Undernivå er en String
    var description: String {
        guard let description = weatherJsonModelInfo?.weather[0].description else {
            return ""
        }
        return description
    }
    
    func fetchWeather(city: String) {
        
        var recordID: CKRecord.ID?
        
        let predicate = NSPredicate(format: "city = %@", city)
        CloudKitCityRecord.fetchCityRecord(predicate: predicate)  { (result) in
            switch result {
            case .success(let cityRecord):
                DispatchQueue.main.async {
                    recordID = cityRecord.recordID
                    WeatherService().getWeather(city: city) { [self] result in
                        switch result {
                        case .success(let weatherInfo) :
                            DispatchQueue.main.async { [self] in
                                self.weatherJsonModelInfo = weatherJsonModelInfo
                                print("Fra fetchWeather: city = \(city)")
                                let cityRecord = CityRecord(recordID: recordID,
                                                            lat: (weatherInfo?.coord.lat)!,
                                                            lon: (weatherInfo?.coord.lon)!,
                                                            city: city,
                                                            icon: (weatherInfo?.weather[0].icon)!,
                                                            temp: (weatherInfo?.main.temp)!,
                                                            description: (weatherInfo?.weather[0].description)!.capitalizingFirstLetter(),
                                                            deg: (weatherInfo?.wind.deg)!,
                                                            wind_speed: (weatherInfo?.wind.speed)!,
                                                            wind_gust: (weatherInfo?.wind.gust) ?? 0.00)
                                
                                DispatchQueue.main.async {
                                    CloudKitCityRecord.modifyCityRecord(cityRecord: cityRecord) { (result) in
                                        switch result {
                                        case .success:
                                            _ = "Success"
                                        case .failure(let err):
                                            print(err.localizedDescription)
                                        }
                                    }
                                }
                            }
                        case .failure(let err ) :
                            print(err.localizedDescription)
                        }
                    }
                }
            case .failure(_):
                print("Failure")
            }
        }
    }
    
}
