//
//  CityHourlyRecordScrollView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct cityHourlyRecordScrollView: View {
    
    @Binding var hourlyRecords: [HourlyRecord]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack (spacing: 10) {
                    ForEach(hourlyRecords) { hourlyRecord in
                        VStack (spacing: -5) {
                            Text(String(IntervalToHourMin(interval: hourlyRecord.dt)))
                            Image(hourlyRecord.weather_icon)
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                            HStack (spacing: 0) {
                                let msg1 = String(format:"%.0f", hourlyRecord.temp)
                                Text(msg1)
                                    .modifier(ForeGroundColor(temp: hourlyRecord.temp))
                                Text("ºC")
                            }
                            .padding(.bottom, 10)
                            HStack (spacing: 0) {
                                let msg1 = String(format:"%.0f", hourlyRecord.wind_speed )
                                Text(msg1)
                                Text("(")
                                let msg2 = String(format:"%.0f", hourlyRecord.wind_gust)
                                Text(msg2)
                                Text(")")
                            }
                            .padding(.bottom, 10)
                            HStack (spacing: 0) {
                                let rain = hourlyRecord.rain ?? 0.00
                                let snow = hourlyRecord.snow ?? 0.00
                                Text(String(format: "%.1f", rain + snow))
                           }
                        }
                        .font(.system(size: 12, weight: .regular))
                    }
                }
            }
            .frame(height: 100)
        }
        .padding(.leading, -10)
        .padding(.trailing, -10)
    }
}

