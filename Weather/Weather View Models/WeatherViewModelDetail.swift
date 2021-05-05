//
//  WeatherViewModelDetail.swift
//  Weather
//
//  Created by Jan Hovland on 21/03/2021.
//

import Foundation
import CloudKit

class WeatherViewModelDetail: ObservableObject {
    
    @Published private var weatherJsonDetail: WeatherJsonDetail?
    
    ///
    /// Her sjekkes det om f.eks weatherJsonInfoDetail?.current.dt finnes i Json og har en lovlig verdi
    ///
    
    /// Temperaturen er i Kelvin
    var dt: Int {
        guard let dt = weatherJsonDetail?.current.dt else {
            return 0
        }
        return dt
    }

    /// Temperaturen er i Kelvin
    var temp: Double {
        guard let temp = weatherJsonDetail?.current.temp else {
            return 0.0
        }
        return temp
    }

    /// Icon er en String
    var icon: String {
        guard let icon = weatherJsonDetail?.current.weather[0].icon  else {
            return "000"
        }
        return icon
    }
    
    /// description er en String
    var description: String {
        guard let description = weatherJsonDetail?.current.weather[0].description  else {
            return ""
        }
        return description
    }
     
    /// description er en Double
    var gust: Double {
     guard let gust = weatherJsonDetail?.current.wind_gust else {
         return 0.0
         }
         return gust
    }
      
    
}
