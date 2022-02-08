//
//  CityHourly48HourView.swift
//  Weather
//
//  Created by Jan Hovland on 06/05/2021.
//

import SwiftUI

struct cityHourly48HourView: View {
    
    @EnvironmentObject var imageInfo: ImageInfo
    
    @Binding var hourlyRecords0: [HourlyRecord]
    @Binding var hourlyRecords1: [HourlyRecord]
    @Binding var hourlyRecords2: [HourlyRecord]
    @Binding var hourlyRecords0_compact: [HourlyRecord]
    @Binding var hourlyRecords1_compact: [HourlyRecord]
    @Binding var hourlyRecords2_compact: [HourlyRecord]

    var body: some View {
        
        VStack (alignment: .leading) {
            
            Group {
  
                ///
                /// Section 0
                ///
                
                Divider()
                    .background(Color.secondary)

                SectionHeaderView(index: 0)
                
                if !imageInfo.compressed0 {
                    ForEach(hourlyRecords0) { hourlyRecord in
                        DetailLine(hourlyRecord: hourlyRecord)
                    }
                } else {
                    ForEach(hourlyRecords0_compact) { hourlyRecord in
                        DetailLine(hourlyRecord: hourlyRecord)
                    }
                }
                
                HStack {
                    Spacer()
                    Text(imageInfo.sectionFooter0)
                    if imageInfo.compressed0 == false {
                       Image(systemName: "chevron.up")
                            .resizable()
                            .frame(width: 10, height: 10, alignment: .center)
                    } else {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                    Spacer()
                }
                .onTapGesture {
                    imageInfo.compressed0 = !imageInfo.compressed0
                }
                
                Divider()
                    .background(Color.secondary)

                ///
                /// Section 1
                ///
                
                SectionHeaderView(index: 1)

                if !imageInfo.compressed1 {
                    ForEach(hourlyRecords1) { hourlyRecord in
                        DetailLine(hourlyRecord: hourlyRecord)
                    }
                } else {
                    ForEach(hourlyRecords1_compact) { hourlyRecord in
                        DetailLine(hourlyRecord: hourlyRecord)
                    }
                }

                HStack {
                    Spacer()
                    Text(imageInfo.sectionFooter1)
                    if imageInfo.compressed1 == false {
                       Image(systemName: "chevron.up")
                            .resizable()
                            .frame(width: 10, height: 10, alignment: .center)
                    } else {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                    Spacer()
                }
                .onTapGesture {
                    imageInfo.compressed1 = !imageInfo.compressed1
                }
                
                Divider()
                    .background(Color.secondary)

            }
            
            Group {
                
                ///
                /// Section 2
                ///
                
                SectionHeaderView(index: 2)

                if !imageInfo.compressed2 {
                    ForEach(hourlyRecords2) { hourlyRecord in
                        DetailLine(hourlyRecord: hourlyRecord)
                    }
                } else {
                    ForEach(hourlyRecords2_compact) { hourlyRecord in
                        DetailLine(hourlyRecord: hourlyRecord)
                    }
                }

                HStack {
                    Spacer()
                    Text(imageInfo.sectionFooter2)
                    if imageInfo.compressed2 == false {
                       Image(systemName: "chevron.up")
                            .resizable()
                            .frame(width: 10, height: 10, alignment: .center)
                    } else {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                    Spacer()
                }
                .onTapGesture {
                    imageInfo.compressed2 = !imageInfo.compressed2
                }
                
                Divider()
                    .background(Color.secondary)

            }
            
        }
        .padding(-10)
    }
}

struct SectionHeaderView: View {
    var index: Int
    @EnvironmentObject var imageInfo: ImageInfo
    
    var body: some View {
        HStack {
            if index == 0 {
                Text(imageInfo.sectionHeader0)
                    .font(.system(.subheadline, design: .monospaced)).bold()
                MoonPhaseView(value: imageInfo.moonPhase0, size: 13)
                Text(String(format:"%.2f", imageInfo.moonPhase0))
                Image(systemName: "sunrise.fill")
                Text(imageInfo.sunRise0)
                Image(systemName: "sunset.fill")
                Text(imageInfo.sunSet0 + " ")
            } else if index == 1 {
                Text(imageInfo.sectionHeader1)
                    .font(.system(.subheadline, design: .monospaced)).bold()
                MoonPhaseView(value: imageInfo.moonPhase1, size: 13)
                Text(String(format:"%.2f", imageInfo.moonPhase1))
                Image(systemName: "sunrise.fill")
                Text(imageInfo.sunRise1)
                Image(systemName: "sunset.fill")
                Text(imageInfo.sunSet1 + " ")
            } else if index == 2 {
                Text(imageInfo.sectionHeader2)
                    .font(.system(.subheadline, design: .monospaced)).bold()
                MoonPhaseView(value: imageInfo.moonPhase2, size: 13)
                Text(String(format:"%.2f", imageInfo.moonPhase2))
                Image(systemName: "sunrise.fill")
                Text(imageInfo.sunRise2)
                Image(systemName: "sunset.fill")
                Text(imageInfo.sunSet2 + " ")
            }
            Spacer()

        }
        .font(.system(size: 13.5, weight: .regular))
        .background(Color("Background"))
    }
    
}

struct HourDaySectionHeaderView: View {
    
    @EnvironmentObject var imageInfo: ImageInfo
    
    var hourlyRecord: HourlyRecord
    
    var body: some View {
        HStack {
            Text(" " + hourlyRecord.sectionHeader)
                .font(.system(size: 11, weight: .bold))
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
}

struct DetailLine: View {
    
    var hourlyRecord: HourlyRecord
    
    var body: some View {
        HStack {
            Group {
                Text(String(IntervalToHourMin(interval: (hourlyRecord.dt))))
                Spacer()
                Image(hourlyRecord.weather_icon)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                Spacer()
            }
            Group {
                let msg = String(format:"%.0f", hourlyRecord.temp)
                Text(msg)
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
                Image(systemName: "arrow.down")
                .resizable()
                .frame(width: 8 , height: 20, alignment: .center)
                .rotationEffect(Angle(degrees: Double(hourlyRecord.wind_deg)), anchor: .center)
                .padding(.leading, -5)
                Spacer()
            }
            Group {
                let msg1 = String(format:"%.0f", hourlyRecord.wind_speed)
                let msg2 = " (" + String(format:"%.0f", hourlyRecord.wind_gust) + ")"
                Text(msg1 + msg2)
                Spacer()
            }
            Spacer()
        }
        .font(.system(size: 14, weight: .regular))
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
