//
//  CityPrecipitationStatus.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct CityPrecipitationStatus: View {
    
    /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-return-different-view-types
    
    @Binding var minutesUntilRainStarts: Int
    @Binding var minutesUntilRainStops: Int
    
    var body: some View {
        if minutesUntilRainStarts > 0 {
            let msg = NSLocalizedString("No Precipitation for the next ", comment: "PrecipitationStatus")
            let msg1 = NSLocalizedString(" minutes", comment: "PrecipitationStatus")
            Text(msg + "\(minutesUntilRainStarts)" + msg1)
        }
        if minutesUntilRainStops > 0 {
            let msg = NSLocalizedString("Precipitation will stop in ", comment: "PrecipitationStatus")
            let msg1 = NSLocalizedString(" minutes", comment: "PrecipitationStatus")
            Text(msg + "\(minutesUntilRainStops)" + msg1)
        }
    }
}
