//
//  DailyDetailView.swift
//  Weather
//
//  Created by Jan Hovland on 30/03/2021.
//

import SwiftUI

struct DailyDetailView: View {
    
    var dailyRecord: DailyRecord
    
    var body: some View {
  
        VStack {
            Text(NSLocalizedString("    Diagram   ", comment: "DailyDetailView"))
                .font(.system(size: 100, weight: .regular))
                /// Egendefinert farge Assets.xcassets
                .background(Color("Background"))
                .cornerRadius(20)
            List {

                HStack {
                    Text(NSLocalizedString("Weather description", comment: "DailyDetailView"))
                    Spacer()
                    Text(dailyRecord.weather_description.capitalizingFirstLetter())
                }
               
                HStack (spacing: 3) {
                    Text(NSLocalizedString("Temperature max/min", comment: "DailyDetailView"))
                    Spacer()
                    Text("\(String(format:"%.0f", dailyRecord.temp_min))")
                    Text("/")
                    Text("\(String(format:"%.0f", dailyRecord.temp_max))")
                        .modifier(ForeGroundColor(temp: dailyRecord.temp_min))
                }
               
                HStack {
                    Text(NSLocalizedString("Precipilation", comment: "DailyDetailView"))
                    Spacer()
                    Text("\(String(format:"%.1f", dailyRecord.rain_the1h!)) mm")
                }
                HStack {
                    Text(NSLocalizedString("Probability of precipilation", comment: "DailyDetailView"))
                    Spacer()
                    Text("\(String(format:"%.0f", dailyRecord.pop * 100))%")
                }
                
                DailyDetailWindView(dailyRecord: dailyRecord)
                
                HStack {
                    Text(NSLocalizedString("Pressure", comment: "DailyDetailView"))
                    Spacer()
                    Text("\(dailyRecord.pressure) hPa")
                }
                
                HStack {
                    Text(NSLocalizedString("Humidity", comment: "DailyDetailView"))
                    Spacer()
                    Text("\(dailyRecord.humidity) %")
                }
                
                HStack {
                    Text(NSLocalizedString("UV index", comment: "DailyDetailView"))
                    Spacer()
                    Text("\(String(format:"%.1f", dailyRecord.uvi))")
                }
                
                HStack {
                    Text(NSLocalizedString("Sunrise", comment: "DailyDetailView"))
                    Spacer()
                    Text(IntervalToHourMin(interval: dailyRecord.sunrise))
                }
                
                HStack {
                    Text(NSLocalizedString("Sunset", comment: "DailyDetailView"))
                    Spacer()
                    Text(IntervalToHourMin(interval: dailyRecord.sunset))
                }
                
            }
        }
        .padding()
    }
}


struct DailyDetailWindView: View {
    var dailyRecord: DailyRecord
    var body: some View {
        HStack {
            Text(NSLocalizedString("Wind", comment: "DailyDetailWindView"))
            Spacer()
            HStack {
                Text(String(format:"%.1f", dailyRecord.wind_speed) + "m/s   " + WindDirection(deg: dailyRecord.wind_deg))
                Image("Arrow_north")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .rotationEffect(Angle(degrees: Double(dailyRecord.wind_deg)), anchor: .center)
            }
        }
    }
}
  

