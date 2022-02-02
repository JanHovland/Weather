//
//  DailyDetailView.swift
//  Weather
//
//  Created by Jan Hovland on 30/03/2021.
//

import SwiftUI

struct dailyDetailView: View {
    
    var dailyRecord: DailyRecord
    
    var body: some View {
  
        VStack {
            Text("    Diagram   ")
                .font(.system(size: 100, weight: .regular))
                /// Egendefinert farge Assets.xcassets
                .background(Color("Background"))
                .cornerRadius(20)
            List {

                HStack {
                    Text("Weather description")
                    Spacer()
                    Text(dailyRecord.weather_description.capitalizingFirstLetter())
                }
               
                HStack (spacing: 3) {
                    Text("Temperature max/min")
                    Spacer()
                    Text("\(String(format:"%.0f", dailyRecord.temp_min))")
                    Text("/")
                    Text("\(String(format:"%.0f", dailyRecord.temp_max))")
                        .modifier(ForeGroundColor(temp: dailyRecord.temp_min))
                }
               
                HStack {
                    Text("Precipitation")
                    Spacer()
                    Text("\(String(format:"%.1f", dailyRecord.rain_the1h!)) mm")
                }
                HStack {
                    Text("Probability of precipitation")
                    Spacer()
                    Text("\(String(format:"%.0f", dailyRecord.pop * 100))%")
                }
                
                DailyDetailWindView(dailyRecord: dailyRecord)
                
                HStack {
                    Text("Pressure")
                    Spacer()
                    Text("\(dailyRecord.pressure) hPa")
                }
                
                HStack {
                    Text("Humidity")
                    Spacer()
                    Text("\(dailyRecord.humidity) %")
                }
                
                HStack {
                    Text("UV index")
                    Spacer()
                    Text("\(String(format:"%.1f", dailyRecord.uvi))")
                }
                
                HStack {
                    Text("Sunrise")
                    Spacer()
                    Text(IntervalToHourMin(interval: dailyRecord.sunrise))
                }
                
                HStack {
                    Text("Sunset")
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
            Text("Wind")
            Spacer()
            HStack {
                Text(String(format:"%.1f", dailyRecord.wind_speed) + "m/s   " + WindDirection(deg: dailyRecord.wind_deg))
                Image(systemName: "arrow.down")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .rotationEffect(Angle(degrees: Double(dailyRecord.wind_deg)), anchor: .center)
            }
        }
    }
}
  

