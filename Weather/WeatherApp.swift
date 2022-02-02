//
//  WeatherApp.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            cityMainView().environmentObject(ImageInfo())
        }
    }
}
