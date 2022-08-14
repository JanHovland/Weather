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

func geoCode(url: String, key: String) async -> (error: LocalizedStringKey, name: String, lon: Double, lat: Double) {
    var lonlat : LonLat
    var err: LocalizedStringKey
    
    let url = URL(string: url + key)!
    let urlSession = URLSession.shared
    do {
        let (data, _) = try await urlSession.data(from: url)
        lonlat = try JSONDecoder().decode(LonLat.self, from: data)
        return ("", lonlat.results[0].name, lonlat.results[0].lon, lonlat.results[0].lat)
    }
    catch {
        err = LocalizedStringKey(error.localizedDescription)
        return(err, "", 0,0)
    }
}

/*
 struct ContentView: View {
    var body: some View {
        Text("Test av longitude / latitude")
            .task {
                let url = "https://api.geoapify.com/v1/geocode/search?text=Padlane,NO&format=json&apiKey="
                let key = ""
                var value: (LocalizedStringKey, String, Double, Double)
                await value = geoCode(url: url, key: key)
                if value.0 != "" {
                    print(value.0)
                } else {
                    print("\(value.1) har longitude = \(value.2) og latitude = \(value.3)")
                }
            }
    }
}

*/



