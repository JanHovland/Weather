//
//  CityDailyRecordVerticalView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct cityDailyRecordVerticalView: View {
    
    var dayIndex: Int
    @Binding var dailyRecords: [DailyRecord]
    
    var body: some View {
        VStack {
            HStack {
                Text("Precipitation")
                Spacer()
                Text("\(String(format:"%.1f", dailyRecords[dayIndex].rain_the1h!)) mm")
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("Probability of precipitation")
                Spacer()
                Text("\(String(format:"%.0f", dailyRecords[dayIndex].pop * 100))%")
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("Wind")
                Spacer()
                HStack (spacing: 5) {
                    Spacer()
                    Text(String(format:"%.1f", dailyRecords[dayIndex].wind_speed) + "m/s")
                    Text(WindDirection(deg: dailyRecords[dayIndex].wind_deg))
                    Image(systemName: "arrow.down")
                        .resizable()
                        .frame(width: 32.5 , height: 32.5, alignment: .center)
                        .rotationEffect(Angle(degrees: Double(dailyRecords[dayIndex].wind_deg)), anchor: .center)
                        .padding(.leading, -5)
                }
                .padding(.trailing, -10)
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("Pressure")
                Spacer()
                Text("\(dailyRecords[dayIndex].pressure) hPa")
            }
            .padding(.bottom, 5)

            HStack {
                Text("Humidity")
                Spacer()
                Text("\(dailyRecords[dayIndex].humidity)%")
            }
            .padding(.bottom, 5)

            HStack {
                Text("UV index")
                Spacer()
                Text(String(format:"%.1f", dailyRecords[dayIndex].uvi))
            }
            .padding(.bottom, 5)

            HStack {
                Text("Sunrise")
                Spacer()
                Text(IntervalToHourMin(interval: dailyRecords[dayIndex].sunrise))
                    .font(.custom("Andale Mono Normal", size: 13))
            }
            .padding(.bottom, 5)

            HStack {
                Text("Sunset")
                Spacer()
                Text(IntervalToHourMin(interval: dailyRecords[dayIndex].sunset))
                    .font(.custom("Andale Mono Normal", size: 13))
            }
            .padding(.bottom, 5)
        }
        .font(.system(size: 13, weight: .regular))
    }
}
           

