//
//  CityDailyRecordScrollView.swift
//  Weather
//
//  Created by Jan Hovland on 21/12/2021.
//

import SwiftUI

struct cityDailyRecordScrollView: View {
    
    @Binding var dailyRecords: [DailyRecord]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 10) {
                    ForEach(dailyRecords) { dailyRecord in
                        VStack (spacing: -5) {
                            Text(String(IntervalToWeekDay(interval: dailyRecord.dt)))
                            Image(dailyRecord.weather_icon)
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                            HStack (spacing: 0) {
                                let msg1 = String(format:"%.0f", dailyRecord.temp_max)
                                Text(msg1)
                                    .modifier(ForeGroundColor(temp: dailyRecord.temp_max))
                                Text("ºC")
                            }
                            .padding(.bottom, 10)
                            HStack (spacing: 0) {
                                let msg1 = String(format:"%.0f", dailyRecord.wind_speed )
                                Text(msg1)
                                Text("(")
                                let msg2 = String(format:"%.0f", (dailyRecord.wind_gust ?? dailyRecord.wind_speed))
                                Text(msg2)
                                Text(")")
                            }
                            .padding(.bottom, 10)
                            HStack (spacing: 0) {
                                let rain = dailyRecord.rain_the1h ?? 0.00
                                let snow = dailyRecord.snow_the1h ?? 0.00
                                Text(String(format: "%.1f", rain + snow))
                           }

                        }
                        .font(.system(size: 12, weight: .regular))
                    }
                }
            }
        }
        .padding(.leading, -12)
    }
}

