//
//  CityCurrentRecordTopView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct CityCurrentRecordTopView: View {
    
    @Binding var currentRecord: CurrentRecord
    
    var body: some View {
        VStack (alignment: .center) {
            
            VStack {
                let msg = Text(NSLocalizedString(" Weather at: ", comment: "currentRecordTopView"))
                let dt = IntervalToHourMin(interval: currentRecord.dt)
                Text("\(msg) \(dt)")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.green)
            }
            
            HStack (spacing: 0)  {
                Image(currentRecord.weather_icon)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                Text(currentRecord.weather_description.capitalizingFirstLetter())
            }
            
            VStack {
                HStack {
                    Text("\(String(format:"%.0f", currentRecord.temp))")
                        .modifier(ForeGroundColor(temp: currentRecord.temp))
                    Text("º C")
                }
            }
            .font(.system(size: 70, weight: .ultraLight))
            .padding(.top, -10)
            
            ///
            /// Temperaturen føles som
            ///
            
            VStack {
                HStack {
                    Spacer()
                    Text(NSLocalizedString("Feels like: ", comment: "currentRecordTopView"))
                    Text(String(format:"%.0f", currentRecord.feels_like))
                        .modifier(ForeGroundColor(temp: currentRecord.feels_like))
                    Text("º C")
                    Spacer()
                }
            }
            .padding(.bottom, 10)
        }
    }
}

