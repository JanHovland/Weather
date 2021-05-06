//
//  CityDailyRecordVerticalView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct CityDailyRecordVerticalView: View {
    
    var dayIndex: Int
    @Binding var dailyRecords: [DailyRecord]
    
    var body: some View {
        VStack {
            HStack {
                Text(NSLocalizedString("Precipitation", comment: "hourlyRecordVerticalView"))
                Spacer()
                Text("\(String(format:"%.1f", dailyRecords[dayIndex].rain_the1h!)) mm")
            }
            .padding(.bottom, 5)
            
            HStack {
                Text(NSLocalizedString("Probability of precipication", comment: "hourlyRecordVerticalView"))
                Spacer()
                Text("\(String(format:"%.0f", dailyRecords[dayIndex].pop * 100))%")
            }
            .padding(.bottom, 5)
            
            HStack {
                Text(NSLocalizedString("Wind", comment: "hourlyRecordVerticalView"))
                Spacer()
                HStack (spacing: 5) {
                    Spacer()
                    Text(String(format:"%.1f", dailyRecords[dayIndex].wind_speed) + "m/s")
                    Text(WindDirection(deg: dailyRecords[dayIndex].wind_deg))
                    Image("Arrow_north")
                        .resizable()
                        .frame(width: 32.5 , height: 32.5, alignment: .center)
                        .rotationEffect(Angle(degrees: Double(dailyRecords[dayIndex].wind_deg)), anchor: .center)
                        .padding(.leading, -5)
                }
                .padding(.trailing, -10)
            }
            .padding(.bottom, 5)
            
            HStack {
                Text(NSLocalizedString("Pressure", comment: "hourlyRecordVerticalView"))
                Spacer()
                Text("\(dailyRecords[dayIndex].pressure) hPa")
            }
            .padding(.bottom, 5)

            HStack {
                Text(NSLocalizedString("Humidity", comment: "hourlyRecordVerticalView"))
                Spacer()
                Text("\(dailyRecords[dayIndex].humidity)%")
            }
            .padding(.bottom, 5)

            HStack {
                Text(NSLocalizedString("UV index", comment: "hourlyRecordVerticalView"))
                Spacer()
                Text(String(format:"%.1f", dailyRecords[dayIndex].uvi))
            }
            .padding(.bottom, 5)

            HStack {
                Text(NSLocalizedString("Sunrise", comment: "hourlyRecordVerticalView"))
                Spacer()
                Text(IntervalToHourMin(interval: dailyRecords[dayIndex].sunrise))
                    .font(.custom("Andale Mono Normal", size: 13))
            }
            .padding(.bottom, 5)

            HStack {
                Text(NSLocalizedString("Sunset", comment: "hourlyRecordVerticalView"))
                Spacer()
                Text(IntervalToHourMin(interval: dailyRecords[dayIndex].sunset))
                    .font(.custom("Andale Mono Normal", size: 13))
            }
            .padding(.bottom, 5)
        }
        .font(.system(size: 13, weight: .regular))
    }
}
           

