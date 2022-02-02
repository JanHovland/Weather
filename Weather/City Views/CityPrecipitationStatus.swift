//
//  CityPrecipitationStatus.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct cityPrecipitationStatus: View {
    
    /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-return-different-view-types
    
    var precipitation: Precipitation
    
    var body: some View {
        
        VStack (alignment: .center) {
            if precipitation.maxRain60Minutes > 0.00, precipitation.minutesUntilRainStarts > 0 {
                ///
                /// Det  regner i løpet av de neste 60 minuttene
                ///
                HStack {
                    Spacer()
                    Text("Precipitation will start in about ")
                    Text("\(precipitation.minutesUntilRainStarts)")
                    Text(" minute(s).")
                    Spacer()
                }
            } else if precipitation.maxRain60Minutes > 0.00, precipitation.minutesUntilRainStarts == 0 {
                ///
                /// Det  regner i løpet av de neste 60 minuttene
                ///
                HStack {
                    Spacer()
                    Text("Precipitation in the next hour.")
                    Spacer()
                }
            } else if precipitation.maxRain8Hours > 0.00, precipitation.hoursUntilRainStarts > 0 {
                ///
                /// Det regn i løpet av de neste 8 timene
                ///
                HStack {
                    Spacer()
                    Text("Precipitation will start in about ")
                    Text("\(precipitation.hoursUntilRainStarts)")
                    Text(" hour(s).")
                    Spacer()
                }
            } else if precipitation.maxRain8Hours > 0.00, precipitation.hoursUntilRainStarts == 0 {
                ///
                /// Det  regner i løpet av de neste 8 timene
                ///
                HStack {
                    Spacer()
                    Text("Precipitation in the next 8 hours.")
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    Text("No Precipitation in the next 8 hours.")
                    Spacer()
                }
            }
        }
        .font(.system(size: 14, weight: .regular))
        
    }
}
