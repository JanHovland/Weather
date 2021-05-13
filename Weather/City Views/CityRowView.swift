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

struct CityRowView: View {
    
    var cityRecord: CityRecord
    
    var body: some View {
        HStack (spacing: 1) {
            if cityRecord.icon != "000" {
                Text(cityRecord.city)
                Spacer()
                Text("\(Int(round(cityRecord.temp)))")
                    .modifier(ForeGroundColor(temp: cityRecord.temp))
                Text(" º C")
                Image(cityRecord.icon)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                Image("Arrow_north")
                    .resizable()
                    .frame(width: 50 , height: 50, alignment: .center)
                    .rotationEffect(Angle(degrees: Double(cityRecord.deg)), anchor: .center)
                    .padding(.bottom, -5)
                
                let msg1 = String(format:"%.0f", cityRecord.wind_speed)
                let msg2 = " (" + String(format:"%.0f", cityRecord.wind_gust!) + ")"
                Text(msg1 + msg2)
            }
        }
        .font(.system(size: 16, weight: .regular))
    }
}

