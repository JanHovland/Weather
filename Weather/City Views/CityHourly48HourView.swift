//
//  CityHourly48HourView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct CityHourly48HourView: View {
    
    @Binding var hourlyRecords: [HourlyRecord]
    @Binding var dailyRecords: [DailyRecord]

    var body: some View {
        List {
            ForEach(hourlyRecords) { hourlyRecord in
                VStack (alignment: .leading) {
                    
                    ///
                    /// Markere ukedagen med bakgrunn på hele linjen
                    ///
                    
                    if hourlyRecord.sectionHeading.count > 0 {
                    
                        HStack {
                            Text(" " + hourlyRecord.sectionHeading)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.accentColor)
                            
                            Spacer()

                            ///
                            /// Markere Måne fasen
                            ///
                            
                            MoonPhaseView(value: hourlyRecord.moon_phase, size: 13)
                            Text(String(format:"%.2f", hourlyRecord.moon_phase))
                                .font(.system(size: 11, weight: .regular))
                            
                            ///
                            /// Markere soloppgang og solnedgang
                            ///
                            
                            Image(systemName: "sunrise.fill")
                                .font(.system(size: 14, weight: .regular))
                            Text(hourlyRecord.sunrise)
                                .font(.system(size: 11, weight: .regular))

                            Image(systemName: "sunset.fill")
                                .font(.system(size: 14, weight: .regular))
                            Text(hourlyRecord.sunset + " ")
                                .font(.system(size: 11, weight: .regular))
                            
                        }
                        .background(Color("Background"))
                        .cornerRadius(4)
                        .padding(.leading, -10)
                        .padding(.trailing, -10)
                    }
                    
                    HStack {
                        Group {
                            Text(String(IntervalToHourMin(interval: (hourlyRecord.dt))))
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
                            Image("Arrow_north")
                                .resizable()
                                .frame(width: 40 , height: 40, alignment: .center)
                                .rotationEffect(Angle(degrees: Double(hourlyRecord.wind_deg)), anchor: .center)
                                .padding(.top, 5)
                                .padding(.leading, -10)
                            Spacer()
                        }
                        Group {
                            let msg1 = String(format:"%.0f", hourlyRecord.wind_speed)
                            let msg2 = " (" + String(format:"%.0f", hourlyRecord.wind_gust) + ")"
                            Text(msg1 + msg2)
                            Spacer()
                        }
                    }
                    .font(.system(size: 15, weight: .regular))
                }
            }
        }
        .padding(.top, 20)
        .frame(height: 1000)
    }
}

