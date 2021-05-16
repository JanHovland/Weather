//
//  CityPrecipitationStatus.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct CityPrecipitationStatus: View {
    
    /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-return-different-view-types
    
    var precipitation: Precipitation
    
    var body: some View {
        
        VStack (alignment: .center) {
            if precipitation.maxRain60Minutes > 0.00, precipitation.minutesUntilRainStarts > 0 {
                ///
                /// Det  regner i løpet av de neste 60 minuttene
                ///
                let msg = NSLocalizedString("Precipitation will start in ", comment: "CityDetailView")
                let msg1 = NSLocalizedString(" minute(s).",  comment: "CityDetailView")
                Text(msg + "\(precipitation.minutesUntilRainStarts)" + msg1)
            } else if precipitation.maxRain60Minutes > 0.00, precipitation.minutesUntilRainStarts == 0 {
                ///
                /// Det  regner i løpet av de neste 60 minuttene
                ///
                let msg = NSLocalizedString("Precipitation in the next 60 minutes.", comment: "CityDetailView")
                Text(msg)
            } else if precipitation.maxRain8Hours > 0.00, precipitation.hoursUntilRainStarts > 0 {
                ///
                /// Det regn i løpet av de neste 8 timene
                ///
                let msg = NSLocalizedString("Precipitation will start in ", comment: "CityDetailView")
                let msg1 = NSLocalizedString(" hour(s).",  comment: "CityDetailView")
                Text(msg + "\(precipitation.hoursUntilRainStarts)" + msg1)
            } else if precipitation.maxRain8Hours > 0.00, precipitation.hoursUntilRainStarts == 0 {
                ///
                /// Det  regner i løpet av de neste 60 minuttene
                ///
                let msg = NSLocalizedString("Precipitation in the next 8 hours.", comment: "CityDetailView")
                Text(msg)
            } else {
                let msg = NSLocalizedString("No Precipitation in the next 8 hours.", comment: "CityDetailView")
                Text(msg)

            }
        }
        .font(.system(size: 14, weight: .regular))
        
    }
}
