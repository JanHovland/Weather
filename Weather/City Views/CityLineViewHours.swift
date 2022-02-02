//
//  CityLineViewHours.swift
//  Weather
//
//  Created by Jan Hovland on 14/04/2021.
//

import SwiftUI

struct cityLineViewHours: View {
    
    @Binding var precipitation: Precipitation
    @Binding var hourlyRecords : [HourlyRecord]
    
    @State private var pointOfTime0 = ""
    @State private var pointOfTime1 = ""
    @State private var pointOfTime2 = ""
    @State private var pointOfTime3 = ""
    @State private var pointOfTime4 = ""
    @State private var pointOfTime5 = ""
    @State private var pointOfTime6 = ""
    @State private var pointOfTime7 = ""
    
    @State private var d0: Double = 5.77
    @State private var d1: Double = 340.00
    @State private var d2: CGFloat = 41.00
    
    var body: some View {
        
        GeometryReader { outer in
            
            ///
            /// Øverste linje
            ///
            
            Path() { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: Double(d1), y: 0))
            }
            .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .square, dash: [4], dashPhase: 1))
            .padding(.bottom, -20)
            .padding(.leading, -20)
            Text("mm")
                .font(.system(size: 13, weight: .regular))
//                .padding(.leading, -20)
                .padding(.leading, -10)

            ///
            /// Oversikt over nedbøren de 8 neste timene
            ///
            
            Path { path in
                let count = precipitation.rain8Hours.count
//                print("maxRain8Hours = \(precipitation.maxRain8Hours)")
                if precipitation.rain8Hours.count > 0 {
                    
                    ///
                    /// Finner korrekt start posisjon
                    ///
                    
                    let y = Double(getYpos (value: precipitation.rain8Hours[0],
                                            maxValue: precipitation.maxRain8Hours,
                                            yHeight: Double(outer.size.height)))
                    
                    path.move(to: CGPoint(x: 0, y: y))
                    
                    for index in 0 ..< count {
                        if precipitation.maxRain8Hours == 0.00 {
                            path.addLine(to: CGPoint(x: Double(Double(d0) * Double(index)), y: Double(outer.size.height)))
                        } else {
                            let y = Double(getYpos (value: precipitation.rain8Hours[index],
                                                    maxValue: precipitation.maxRain8Hours,
                                                    yHeight: Double(outer.size.height)))
                            path.addLine(to: CGPoint(x: Double(Double(d0) * Double(index)), y: y))
                        }
                    }
                }
            }
            .stroke(Color.green, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
//            .padding(.leading, -20)
            .padding(.leading, -10)

            ///
            /// Nedre linje
            ///
            
            Path() { path in
                path.move(to: CGPoint(x: 0, y: Double(outer.size.height)))
                path.addLine(to: CGPoint(x: Double(d1), y: Double(outer.size.height)))
            }
            .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .square, dash: [4], dashPhase: 1))
            .padding(.leading, -20)
            
            HStack {
                Group {
                    Text(pointOfTime0)
                    Spacer()
                    Text(pointOfTime1)
                    Spacer()
                    Text(pointOfTime2)
                    Spacer()
                    Text(pointOfTime3)
                    Spacer()
                    Text(pointOfTime4)
                    Spacer()
                }
                Group {
                    Text(pointOfTime5)
                    Spacer()
                    Text(pointOfTime6)
                    Spacer()
                    Text(pointOfTime7)
                }
            }
            .font(.system(size: 11, weight: .regular))
            .padding(.top, CGFloat(outer.size.height))
            .padding(.leading, -20)
            
        }
        .padding(.bottom, 20)
        .frame(width: UIScreen.screenWidth * d2, height: 75)

        .onAppear {
            if hourlyRecords.count > 0 {
                pointOfTime0 = IntervalToHourMin(interval: hourlyRecords[0].dt)
                pointOfTime1 = IntervalToHourMin(interval: hourlyRecords[1].dt)
                pointOfTime2 = IntervalToHourMin(interval: hourlyRecords[2].dt)
                pointOfTime3 = IntervalToHourMin(interval: hourlyRecords[3].dt)
                pointOfTime4 = IntervalToHourMin(interval: hourlyRecords[4].dt)
                pointOfTime5 = IntervalToHourMin(interval: hourlyRecords[5].dt)
                pointOfTime6 = IntervalToHourMin(interval: hourlyRecords[6].dt)
                pointOfTime7 = IntervalToHourMin(interval: hourlyRecords[7].dt)
//                print("************hourlyRecords.count = \(hourlyRecords.count)")
            }
            else {
                print("error")
            }
            
            if UIScreen.screenWidth == 375.0  {
                d0 = 48.25 // 48.75  
                d1 = 340.00
                d2 = 0.85
            } else if UIScreen.screenWidth == 667.0 {
                d0 = 90.00
                d1 = 631.00
                d2 = 0.85
            } else if UIScreen.screenWidth == 834.0 {
                d0 = 130.00
                d1 = 800.00
                d2 = 0.935
            } else if UIScreen.screenWidth == 1112.0 {
                d0 = 122.00
                d1 = 755.00
                d2 = 0.660
            }
            
        }
        
    }
    
}

