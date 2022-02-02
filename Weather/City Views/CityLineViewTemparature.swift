//
//  CityLineViewTemparature.swift
//  Weather
//
//  Created by Jan Hovland on 22/04/2021.
//

import SwiftUI

struct cityLineViewTemparature: View {
    
    @Binding var hourlyRecords: [HourlyRecord]
    @Binding var precipitation: Precipitation

    @State private var d0: Double = 0.00
    @State private var d1: Double = 0.00
    @State private var d2: CGFloat = 0.00
    
    var body: some View {
        
        GeometryReader { outer in
            
            ///
            /// Toppen
            ///
            
            VStack (alignment: .leading) {
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: Double(d1), y: 0))
                }
                .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .square, dash: [4], dashPhase: 1))
                .padding(.bottom, -13)
                
                
                Text("ºC")
                    .font(.system(size: 13, weight: .regular))
                
            }
            .padding(.leading, 0)
            
            ///
            /// Vise temperaur og nedbør
            ///
            
            Path { path in
                let y = Double(getYpos (value: hourlyRecords[0].temp,
                                        maxValue: precipitation.maxTemperature + 2.0,
                                        yHeight: Double(70)))
                path.move(to: CGPoint(x: 0, y: y))
                
                for index in 0..<48 {
                    let y = Double(getYpos (value: hourlyRecords[index].temp,
                                            maxValue: precipitation.maxTemperature + 2.0,
                                            yHeight: Double(70)))
                    path.addLine(to: CGPoint(x: Double(Double(48.25) * Double(index)), y: y))
                }
            }
            .stroke(Color(.green))
            .frame(width: UIScreen.screenWidth * d2, height: 100) //140)
            
            ///
            /// Nedre linje
            ///
            
            Path() { path in
                path.move(to: CGPoint(x: 0, y: Double(22)))
                path.addLine(to: CGPoint(x: Double(d1), y: Double(22)))
            }
            .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .square, dash: [4], dashPhase: 1))
            .frame(width: UIScreen.screenWidth * d2, height: 50)
            .padding(.top, 130)
            
            ///
            /// Skalering 00:00 til 24:00
            ///
            
            HStack (spacing: 23) {
                Text("00")
                Text("03")
                Text("06")
                Text("09")
                Text("12")
                Text("15")
                Text("18")
                Text("21")
                Text("24")
            }
            .font(.system(size: 11, weight: .regular))
            .padding(.top, 250)
            .padding(.leading, 15)
            .padding(.bottom, 13)
            .frame(width: UIScreen.screenWidth * d2, height: 75)
        }
        .onAppear {
            if UIScreen.screenWidth == 375.0  {
                d0 = 5.77
                d1 = 340.00
                d2 = 0.85
            } else if UIScreen.screenWidth == 667.0 {
                d0 = 10.6750
                d1 = 631.00
                d2 = 0.85
            } else if UIScreen.screenWidth == 834.0 {
                d0 = 13.60
                d1 = 800.00
                d2 = 0.935
            } else if UIScreen.screenWidth == 1112.0 {
                d0 = 12.80
                d1 = 755.00
                d2 = 0.660
            }
        }
        
    }
}

