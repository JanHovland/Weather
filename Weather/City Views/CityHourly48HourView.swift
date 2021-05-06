//
//  CityHourly48HourView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct CityHourly48HourView: View {
    
    @Binding var hourlyRecords: [HourlyRecord]
    
    var body: some View {
        List {
            ForEach(hourlyRecords) { hourlyRecord in
                VStack (alignment: .leading) {
                    
                    ///
                    /// Markere ukedagen med bakgrunn på hele linjen
                    ///
                    
                    if hourlyRecord.sectionHeading.count > 0 {
                        HStack {
                            Text(hourlyRecord.sectionHeading)
                            Spacer()
                        }
                        .background(Color("Background"))
                        .cornerRadius(4)
                        .padding(.leading, -10)
                        .padding(.trailing, -10)
                        
                        ///
                        /// Markere soloppgang og solnedgang
                        ///
                        
                        VStack (alignment: .center) {
                            let msg = NSLocalizedString("Sunrise", comment: "hourly48HourView")
                            Text(msg + ":\t" + hourlyRecord.sunrise)
                            let msg1 = NSLocalizedString("Sunset", comment: "hourly48HourView")
                            Text(msg1 + ":\t" + hourlyRecord.sunset)
                        }
                        .font(Font.footnote.weight(.regular))
                        .foregroundColor(.green)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        
                    }
                    
                    HStack {
                        Group {
                            Text(String(IntervalToHour(interval: (hourlyRecord.dt))))
                            Spacer()
                            Image(hourlyRecord.weather_icon)
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                            Spacer()
                            let msg1 = String(format:"%.0f", hourlyRecord.temp)
                            Text(msg1)
                                .modifier(ForeGroundColor(temp: hourlyRecord.temp))
                                .font(.system(size: 18, weight: .regular))
                            Text("ºC")
                            Spacer()
                            let msg1 = String(format:"%.1f", hourlyRecord.rain!)
                            if msg1 == "0.0" {
                                Text("              ")
                            } else {
                                Text(msg1 + " mm")
                            }
                            Spacer()
                        }
                        Group {
                            let msg1 = String(format:"%.0f", hourlyRecord.wind_speed)
                            let msg2 = " (" + String(format:"%.0f", hourlyRecord.wind_gust) + ")"
                            Text(msg1 + msg2)
                            Spacer()
                        }
                        Group {
                            Image("Arrow_north")
                                .resizable()
                                .frame(width: 40 , height: 40, alignment: .center)
                                .rotationEffect(Angle(degrees: Double(hourlyRecord.wind_deg)), anchor: .center)
                                .padding(.top, 5)
                                .padding(.leading, -10)
                            Spacer()
                        }
                        
                    }
                }
            }
        }
        .padding(.top, 20)
        .frame(height: 1000)
    }
}

