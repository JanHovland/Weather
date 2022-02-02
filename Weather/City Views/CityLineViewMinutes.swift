//
//  CityLineViewMinutes.swift
//  Weather
//
//  Created by Jan Hovland on 06/04/2021.
//

import SwiftUI

struct cityLineViewMinutes: View {
    
    @Binding var precipitation: Precipitation
    @Binding var minutelyRecords : [MinutelyRecord]
    
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
            .padding(.leading, -15)
            Text("mm/h") 
                .font(.system(size: 13, weight: .regular))
                .padding(.leading, -15)
            
            ///
            /// Oversikt over nedbøren den neste timen
            ///
            
            Path { path in
                let count = minutelyRecords.count
                if minutelyRecords.count > 0 {
                    
                    ///
                    /// Finner korrekt start posisjon
                    ///
                    
                    let y = Double(getYpos (value: minutelyRecords[0].precipitation,
                                            maxValue: precipitation.maxRain60Minutes,
                                            yHeight: Double(outer.size.height)))
                    
                    path.move(to: CGPoint(x: 0, y: y))
                    
                    for index in 0 ..< count {
                        if precipitation.maxRain60Minutes == 0.00 {
                            path.addLine(to: CGPoint(x: Double(Double(d0) * Double(index)), y: Double(outer.size.height)))
                        } else {
                            let y = Double(getYpos (value: minutelyRecords[index].precipitation,
                                                    maxValue: precipitation.maxRain60Minutes,
                                                    yHeight: Double(outer.size.height)))
                            path.addLine(to: CGPoint(x: Double(Double(d0) * Double(index)), y: y))
                        }
                    }
                }
            }
            .stroke(Color.green, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
            .padding(.leading, -15)
            
            ///
            /// Nedre linje
            ///
            
            Path() { path in
                path.move(to: CGPoint(x: 0, y: Double(outer.size.height)))
                path.addLine(to: CGPoint(x: Double(d1), y: Double(outer.size.height)))
            }
            .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .square, dash: [4], dashPhase: 1))
            .padding(.leading, -15)
            
            HStack {
                Text("Now")
                Spacer()
                Text("15min")
                Spacer()
                Text("30min")
                Spacer()
                Text("45min")
                Spacer()
                Text("60min")
            }
            .font(.system(size: 13, weight: .regular))
            .padding(.top, CGFloat(outer.size.height))
            .padding(.leading, -15)
        }
        
        .padding(.bottom, 20)
        .frame(width: UIScreen.screenWidth * d2, height: 75)
        
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
            } else if UIScreen.screenWidth == 2048.0 {
                d0 = 23.0
                d1 = 1357.0
                d2 = 0.660
            }
        }
    }
    
}

func getYpos (value: Double,                     // 1                    2
              maxValue: Double,                  // 2                    2
              yHeight: Double) -> Double {       // 32    -----> 16     32 -----> 0
    
    ///                           value
    ///             y =    yHeight  -   -----------------  *  yHeight
    ///                          maxValue
    
    return  yHeight - (value / maxValue) *  yHeight
    
}


extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}



