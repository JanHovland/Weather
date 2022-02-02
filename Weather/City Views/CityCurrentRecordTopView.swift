//
//  CityCurrentRecordTopView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct cityCurrentRecordTopView: View {
    
    @Binding var currentRecord: CurrentRecord
    @Binding var dailyRecords: [DailyRecord]
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (alignment: .center) {
            
            VStack {
                HStack {
                    
                    HStack (spacing: 0) {
                        Image(systemName: "sunrise.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .center)
                            .padding(5)
                        Text(IntervalToHourMin(interval: currentRecord.sunrise))
                    }
                    
                    Spacer()
                    Spacer()
                    MoonPhaseView(value: dailyRecords[0].moon_phase, size: 40)
                    Text("\(String(format:"%.2f", dailyRecords[0].moon_phase))")
                    
                    Spacer()
                    Spacer()
                    
                    HStack (spacing: 0) {
                        Image(systemName: "sunset.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .center)
                            .padding(5)
                        Text(IntervalToHourMin(interval: currentRecord.sunset))
                    }
                    
                }
                
                let msg = Text(" Weather at: ")
                let dt = IntervalToHourMin(interval: currentRecord.dt)
                Text("\(msg) \(dt)")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.green)
            }
            
            HStack (spacing: 0)  {
                Image(currentRecord.weather_icon)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                Text(currentRecord.weather_description.capitalizingFirstLetter())
            }
            
            VStack {
                HStack {
                    Text("\(String(format:"%.0f", currentRecord.temp))")
                        .modifier(ForeGroundColor(temp: currentRecord.temp))
                    Text("º C")
                }
            }
            .font(.system(size: 70, weight: .ultraLight))
            .padding(.top, -10)
            
            ///
            /// Temperaturen føles som
            ///
            
            VStack {
                HStack {
                    Spacer()
                    Text("Feels like: ")
                    Text(String(format:"%.0f", currentRecord.feels_like))
                        .modifier(ForeGroundColor(temp: currentRecord.feels_like))
                    Text("º C")
                    Spacer()
                }
            }
            .padding(.bottom, 10)
        }
    }
}

/*
 
 11. mai = 0        moon3
 12. mai = 0.02
 13. mai = 0.05
 14. mai = 0.08
 15. mai = 0.11
 16. mai = 0.14
 17. mai = 0.17
 18. mai = 0.20
 19. mai = 0.25    moon4
 20. mai = 0.27 
 21. mai = 0.31
 22. mai = 0.34
 23. mai = 0.38
 24. mai = 0.42
 25. mai = 0.46
 26. mai = 0.50    moon1
 27. mai = 0.54
 28. mai = 0.58
 29. mai = 0.61
 30. mai = 0.65
 31. mai = 0.69
  1. jun =
  2. jun = (.75)    moon2
  3. jun =
  4. jun =
  5. jun =
  6. jun =
  7. jun =
  8. jun =
  9. jun =
 10. jun = (0)      moon3
 11. jun = 


*/

struct MoonPhaseView: View {

    var value: Double
    var size: CGFloat

    var body: some View {

        if 0.00...0.01 ~= value {
            MoonPhaseWholeView(width: size, height: size, color: .black)
        } else if 0.02...0.49 ~= value {
            MoonPhaseSideView(width: size, height: size, left: .black)
        } else if 0.50...0.51  ~= value {
            MoonPhaseWholeView(width: size, height: size, color: .white)
        } else {
            MoonPhaseSideView(width: size, height: size, left: .white)
        }
    }
}

struct MoonPhaseSideView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var width: CGFloat
    var height: CGFloat
    var left: Color
    
    var body: some View {
        
        if left == .white {
            Circle()
                .trim(from: 0, to: 0.5)
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: colorScheme == .dark ? 90 : 270), anchor: .center)
                .overlay(Circle().stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: colorScheme == .dark ? 1 : 2))
        } else if left == .black {
            Circle()
                .trim(from: 0, to: 0.5)
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: colorScheme == .dark ? 270 : 90), anchor: .center)
                .overlay(Circle().stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: colorScheme == .dark ? 1 : 2))
        }
    }
}
        
struct MoonPhaseWholeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var width: CGFloat
    var height: CGFloat
    var color: Color
    
    var body: some View {
        Circle()
            .frame(width: width, height: height)
            .foregroundColor(color)
            .overlay(Circle().stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: colorScheme == .dark ? 1 : 2
            ))
    }
}
        
