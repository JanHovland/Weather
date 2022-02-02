//
//  CityRowView.swift
//  Weather
//
//  Created by Jan Hovland on 14/03/2021.
//

///
/// Creating Transparent Images With Keynote (#1387​)
/// https://www.youtube.com/watch?v=ssEsvUXUvfc
///

import SwiftUI

struct cityRowView: View {
    
    var cityRecord: CityRecord
    
    var body: some View {
        
        HStack (spacing: 25) {
            HStack {
                Text(cityRecord.city)
                    .frame(width: 150, alignment: .leading)
                    
            }
            HStack {
                Text("Lat: \(String(format:"%.4f", cityRecord.lat))")
                Text("Lon: \(String(format:"%.4f", cityRecord.lon))")
            }
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(.green)
        }
    }
}
