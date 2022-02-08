//
//  CityDayView.swift
//  Weather
//
//  Created by Jan Hovland on 12/04/2021.
//

import SwiftUI

struct cityDayView: View {
    
    @Binding var currentRecord: CurrentRecord
    @Binding var hourlyRecords: [HourlyRecord]
    @Binding var precipitation: Precipitation
    
    @State var dailyRecords: [DailyRecord]
    @State var currentRecordIndex: Int
    
    @State private var isRecordTapped = false
    
    @GestureState private var dragOffset: CGFloat = 0
    
    struct ColorModel: Identifiable {
        var value: Color
        let id = UUID()
    }
    
    @State private var colors = [
        ColorModel(value: Color.clear),
        ColorModel(value: Color.clear),
        ColorModel(value: Color.clear),
        ColorModel(value: Color.clear),
        ColorModel(value: Color.clear),
        ColorModel(value: Color.clear),
        ColorModel(value: Color.clear),
        ColorModel(value: Color.clear),
    ]
    
    var body: some View {
        
        List {
            
            ///
            ///  currentRecord top View
            ///
            
            cityCurrentRecordTopView(currentRecord: $currentRecord,
                                     dailyRecords: $dailyRecords)
                                     
            
            ///
            /// Oversikt over de neste 48 timene
            ///
            
            cityHourlyRecordScrollView(hourlyRecords: $hourlyRecords)
            
            ///
            //// Viser  idag + de 7 neste dagene
            ///
            
            HStack (spacing: 20) {
                ForEach(dailyRecords.indices, id: \.self) { index in
                    VStack (alignment: .center) {
                        Text(String(IntervalToWeekDay(interval: dailyRecords[index].dt)))
                        Text(String(IntervalToDayOfMonth(interval: dailyRecords[index].dt)))
                    }
                    .gesture(
                        TapGesture()
                            .onEnded({ _ in
                                let count = dailyRecords.count
                                for i in 0..<count {
                                    colors[i].value =  Color.clear
                                }
                                colors[index].value =  Color(.green).opacity(0.4)

                                ///
                                /// Hvis ikke currentRecordIndex er definert som:  @State var currentRecordIndex: Int
                                /// men som: var currentRecordIndex: Int
                                /// kommer denne feilmeldingen: Cannot assign to property: 'self' is immutable
                                ///
                                currentRecordIndex = index
                            })
                    )
                    .background(index == currentRecordIndex ? Color(.green).opacity(0.4) :  Color.clear)
                }
            }
            .padding(.top, -10)
            
            ///
            /// Carousel
            ///
            
            GeometryReader { outerView in
                HStack(spacing: 0) {
                    ForEach(dailyRecords.indices, id: \.self) { index in
                        GeometryReader { innerView in
                            VStack {
                                HStack (spacing: 0) {
                                    Text(dailyRecords[index].weather_description.capitalizingFirstLetter())
                                        .font(.system(size: 25, weight: .regular))
                                        .foregroundColor(.primary)
                                    HStack (spacing: 0) {
                                        Spacer()
                                        let msg = String(format:"%.0f", dailyRecords[index].temp_min)
                                        Text(msg)
                                            .font(.system(size: 30, weight: .regular))
                                            .modifier(ForeGroundColor(temp: dailyRecords[index].temp_min))
                                        Text("/")
                                            .padding(.top, 5)
                                            .font(.system(size: 30, weight: .regular))
                                        let msg1 = String(format:"%.0f", dailyRecords[index].temp_max)
                                        Text(msg1)
                                            .font(.system(size: 30, weight: .regular))
                                            .modifier(ForeGroundColor(temp: dailyRecords[index].temp_max))
                                        Text(" º C")
                                            .font(.system(size: 30, weight: .regular))
                                        Image(dailyRecords[index].weather_icon)
                                    }
                                }
                                .padding(.horizontal)
                                
                                ///
                                /// Temperatur og nedbør
                                /// 
                                
                                cityLineViewTemparature(hourlyRecords: $hourlyRecords,
                                                        precipitation: $precipitation)
                                     .padding(.bottom, 160)
                                
                                ///
                                /// Daglige vær data
                                ///
                                
                                cityDailyRecordVerticalView(dayIndex: index,
                                                        dailyRecords: $dailyRecords)
                                    .padding(.top, 20)
                                    .padding(.trailing, 20)
                            }
                            
                        }
                        .frame(width: outerView.size.width + 20.0, height: outerView.size.height)
                    }
                }
                .font(.system(size: 13, weight: .regular))
                .offset(x: -CGFloat(currentRecordIndex) * (outerView.size.width + 20.0))
                .offset(x: dragOffset)
                .gesture(
                    !isRecordTapped ?
                        DragGesture()
                        .updating($dragOffset, body: { (value, state, transaction) in
                            state = value.translation.width
                        })
                        .onEnded({ (value) in
                            
                            ///
                            /// Hvor stor del av bildet må jeg dra.
                            ///
                            
                            let threshold = outerView.size.width * 0.65
                            var newIndex = Int(-value.translation.width / threshold) + currentRecordIndex
                            newIndex = min(max(newIndex, 0), dailyRecords.count - 1)
                            currentRecordIndex = newIndex
                            
                            ///
                            /// Setter bakgrunn på dag oversikten
                            ///
                            
                            let count = dailyRecords.count
                            for i in 0..<count {
                                colors[i].value =  Color.clear
                            }
                            colors[currentRecordIndex].value =  Color("Background")
                        })
                        : nil
                )
                
            } /// GeometryReader { outerView in
            /// .animation(.default)
            
            ///
            /// Fjerne navigation title
            ///
            
            .navigationBarTitle("", displayMode: .inline)
        } // List
        .onAppear() {
            colors[currentRecordIndex].value = Color("Background")
            UIScrollView.appearance().bounces = true
        }
    }
    
    ///
    /// Skjule navigation title/bar
    ///
    
}


