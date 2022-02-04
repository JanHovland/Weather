//
//  CityDetailView.swift
//  Weather
//
//  Created by Jan Hovland on 14/03/2021.
//

///
/// Creating Transparent Images With Keynote (#1387​)
/// https://www.youtube.com/watch?v=ssEsvUXUvfc
///

///
/// The One Call API provides the following weather data for any geographical coordinates:
///
///     Current weather
///     Minute forecast for 1 hour
///     Hourly forecast for 48 hours
///     Daily forecast for 7 days
///     National weather alerts
///     Historical weather data for the previous 5 days
///

import SwiftUI

struct cityDetailView: View, Sendable {
    
    var city: String
    
    @State private var message: LocalizedStringKey = ""
    @State private var title: String = ""
    @State private var dailyRecords = [DailyRecord]()
    @State private var hourlyRecords = [HourlyRecord]()
    
    @State private var hourlyRecords0 = [HourlyRecord]()
    @State private var hourlyRecords1 = [HourlyRecord]()
    @State private var hourlyRecords2 = [HourlyRecord]()
    
    @State private var hourlyRecords0_compact = [HourlyRecord]()
    @State private var hourlyRecords1_compact = [HourlyRecord]()
    @State private var hourlyRecords2_compact = [HourlyRecord]()
    
    @State private var minutelyRecords = [MinutelyRecord]()
    @State private var alertRecords = [AlertRecord]()
    
    @State private var alertButtonText = ""
    @State private var isRecordTapped: Bool = false
    @State private var isAlertActive = false
    @State private var cityAlertView = false
    
    @State private var i = 0
    
    @State private var precipitation = Precipitation(maxRain60Minutes: 0.00,
                                                     rain60Minutes: [Double](),
                                                     minutesUntilRainStarts: 0,
                                                     minutesUntilRainStops: 0,
                                                     hoursUntilRainStarts: 0,
                                                     hoursUntilRainStops: 0,
                                                     maxRain8Hours: 0.00,
                                                     rain8Hours: [Double]().dropLast(),
                                                     maxTemperature: 0.00)
    
    ///
    /// Legg merke til CurrentRecord sine alerts_ felter alle i tillegg til wind_gust er optional, så de trenger ikke initialiseres!
    ///
    
    @State private var currentRecord = CurrentRecord(dt: 0,
                                                     sunrise: 0,
                                                     sunset: 0,
                                                     temp: 0.0,
                                                     feels_like: 0.0,
                                                     pressure: 0,
                                                     humidity: 0,
                                                     dew_point: 0.0,
                                                     uvi: 0.0,
                                                     clouds: 0,
                                                     visibility: 0,
                                                     wind_speed: 0.0,
                                                     wind_deg: 0,
                                                     weather_id: 0,
                                                     weather_main: "",
                                                     weather_description: "",
                                                     weather_icon: "000")
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var imageInfo: ImageInfo
    
    var body: some View {
        List {
            if currentRecord.weather_icon != "000" {
                
                ///
                /// Oversikt over dagen i dag
                ///
                
                VStack (alignment: .center) {
                    
                    ///
                    ///  currentRecord top View
                    ///
                    
                    cityCurrentRecordTopView(currentRecord: $currentRecord,
                                             dailyRecords: $dailyRecords)
                    
                    ///
                    /// Varsel fra Meteorologisk Institutt
                    ///
                    
                    if alertButtonText.count > 0 {
                        Button(action: {
                            cityAlertView.toggle()
                        })
                        {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                Text(alertButtonText)
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                            }
                            .frame(minWidth: 10, maxWidth: 150)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                        }
                        .sheet(isPresented: $cityAlertView, content: {
                            Weather.cityAlertView(alertRecords: alertRecords)
                        })
                    }
                    
                    ///
                    /// Beskrivelse av nedbøren de neste time(ne)
                    ///
                    
                    cityPrecipitationStatus(precipitation: precipitation)
                }
                
                ///
                /// Oversikt diverse værdata
                ///
                
                VStack {
                    HStack {
                        HStack {
                            Text("Wind: ")
                            Text(String(format:"%.0f", currentRecord.wind_speed) + " m/s")
                            Text(WindDirection(deg: currentRecord.wind_deg))
                            Image(systemName: "arrow.down")
                                .resizable()
                                .frame(width: 6, height: 16, alignment: .center)
                                .rotationEffect(Angle(degrees: Double(currentRecord.wind_deg)), anchor: .center)
                                .padding(.top, -5)
                        }
                        Spacer()
                        HStack {
                            Text("Humidity: ")
                            Text("\(currentRecord.humidity)%")
                        }
                    }
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    HStack {
                        HStack {
                            Text("UV index: ")
                            Text(String(format:"%.1f", currentRecord.uvi))
                        }
                        Spacer()
                        HStack {
                            Text("Pressure: ")
                            Text("\(currentRecord.pressure) hPa")
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.bottom, -10)
                    HStack {
                        HStack {
                            Text("Visibility: ")
                            Text("\(currentRecord.visibility / 1000) km")
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Dew point: ")
                            Text("\(String(format:"%.0f", currentRecord.dew_point))")
                                .modifier(ForeGroundColor(temp: currentRecord.dew_point))
                            Text("º C")
                        }
                    }
                    
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                    
                    ///
                    /// Data for test av PrecipitationStatus()
                    ///
                    
                    /*
                     HStack {
                     HStack {
                     Text("minutesUntilRainStarts ")
                     .font(.system(size: 11.5, weight: .regular))
                     Text("\(precipitation.minutesUntilRainStarts)")
                     }
                     Spacer()
                     HStack {
                     Spacer()
                     Text("minutesUntilRainStops ")
                     .font(.system(size: 11.5, weight: .regular))
                     Text("\(precipitation.minutesUntilRainStops)")
                     }
                     }
                     .foregroundColor(.green)
                     .padding(.leading, 10)
                     .padding(.trailing, 10)
                     .padding(.bottom, 10)
                     
                     HStack {
                     HStack {
                     Text("maxRain60Minutes: ")
                     .font(.system(size: 12, weight: .regular))
                     Text(String(format:"%.2f", precipitation.maxRain60Minutes))
                     }
                     Spacer()
                     HStack {
                     Spacer()
                     Text("maxRain8Hours")
                     .font(.system(size: 12, weight: .regular))
                     Text(String(format:"%.2f", precipitation.maxRain8Hours))
                     }
                     }
                     .foregroundColor(.green)
                     .padding(.leading, 10)
                     .padding(.trailing, 10)
                     .padding(.bottom, 10)
                     
                     HStack {
                     HStack {
                     Text("hoursUntilRainStarts ")
                     .font(.system(size: 11.5, weight: .regular))
                     Text("\(precipitation.hoursUntilRainStarts)")
                     }
                     Spacer()
                     HStack {
                     Spacer()
                     Text("hoursUntilRainStops ")
                     .font(.system(size: 11.5, weight: .regular))
                     Text("\(precipitation.hoursUntilRainStops)")
                     }
                     }
                     .foregroundColor(.green)
                     .padding(.leading, 10)
                     .padding(.trailing, 10)
                     .padding(.bottom, 10)
                     
                     */
                }
                .foregroundColor(.green)
                .font(.system(size: 13, weight: .regular))
                /// Egendefinert farge Assets.xcassets
                .background(Color("Background"))
                .cornerRadius(15)
                .padding(.leading, -10)
                .padding(.trailing, -10)
                
                ///
                /// Oversikt nedbør
                ///
                
                if precipitation.maxRain60Minutes != 0.00 || precipitation.maxRain8Hours != 0.00 {
                    VStack (alignment: .leading) {
                        if precipitation.maxRain60Minutes != 0.00 {
                            Text(String(format:"%.2f", precipitation.maxRain60Minutes))
                                .font(.system(size: 13, weight: .regular))
                                .padding(.leading, -15)
                            cityLineViewMinutes(precipitation: $precipitation,
                                                minutelyRecords: $minutelyRecords)
                        } else if precipitation.maxRain8Hours != 0.00 {
                            Text(String(format:"%.2f", precipitation.maxRain8Hours))
                                .font(.system(size: 13, weight: .regular))
                            cityLineViewHours(precipitation: $precipitation,
                                              hourlyRecords: $hourlyRecords)
                        }
                    }
                }
                
                Divider()
                    .background(Color.secondary)
                
                cityDailyRecordScrollView(dailyRecords: $dailyRecords)
                
                ///
                /// Oversikt over de neste 48 timene, som viser:
                ///     Klokkeslett
                ///     Icon
                ///     Temperatur
                ///     Vind (vindkast)
                
                Divider()
                    .background(Color.secondary)
                
//                cityHourlyRecordScrollView(hourlyRecords: $hourlyRecords)
//
//                Divider()
//                    .background(Color.secondary)
//
                cityHourly48HourView(hourlyRecords0: $hourlyRecords0,
                                     hourlyRecords1: $hourlyRecords1,
                                     hourlyRecords2: $hourlyRecords2,
                                     hourlyRecords0_compact: $hourlyRecords0_compact,
                                     hourlyRecords1_compact: $hourlyRecords1_compact,
                                     hourlyRecords2_compact: $hourlyRecords2_compact)
            }
        }
        
//        .refreshable {
//            await refreshCityRecordDetail()
//        }
        
        .task {
            UITableView.appearance().showsVerticalScrollIndicator = false
            await refreshCityRecordDetail()
            //            print("Modellens bredde = \(UIScreen.screenWidth)")
            //            print("Modellens høyde = \(UIScreen.screenHeight)")
        }
        .navigationBarTitle((currentRecord.weather_icon != "000") ?  city : "")
        .refreshable {
            await refreshCityRecordDetail()
        }
                
    }
    
    /// Rutine for å finne vær detaljene
    func refreshCityRecordDetail() async {
        
       let predicate = NSPredicate(format: "city = %@", city)
        
        Task.init {
            var value: (LocalizedStringKey, [CityRecord])
            await value = findCitys(predicate)
            
            if value.0 != "" {
                message = value.0
                title = NSLocalizedString("Error message from the Server", comment: "refreshCityRecordDetail")
                isAlertActive.toggle()
            } else {
                let cityRecord = value.1[0]
                
                var value1 : (LocalizedStringKey, WeatherDetail)
                await value1 = WeatherServiceDetail().getWeatherDetail(cityRecord.lat,
                                                                       cityRecord.lon)
                if value1.0 == "" {
                    
                    ///
                    /// Daily forecast for 7 days + i dag
                    ///
                    
                    var value2: ([DailyRecord])
                    value2 = setDailyRecords(value: value1.1)
                    dailyRecords = value2
                    
                    
                    ///
                    /// Current record
                    ///
                    
                    var value3: (CurrentRecord)
                    value3 = setCurrentRecord(value: value1.1)
                    currentRecord = value3
                    
                    ///
                    /// Alert records
                    ///
                    
                    var value4: (String, [AlertRecord])
                    value4 = setAlertRecord(value: value1.1)
                    
                    alertButtonText = value4.0
                    alertRecords = value4.1
                    
                    ///
                    /// Henter Minute forecast for 1 hour
                    ///
                    
                    precipitation.maxRain60Minutes = 0.0
                    minutelyRecords.removeAll()
                    precipitation.rain60Minutes.removeAll()
                    
                    for i in 0...59 {
                        let minutelyRecord = MinutelyRecord(dt:            (value1.1.minutely[i].dt),
                                                            precipitation: (value1.1.minutely[i].precipitation))
                        
                        if minutelyRecord.precipitation > precipitation.maxRain60Minutes {
                            precipitation.maxRain60Minutes = minutelyRecord.precipitation
                        }
                        
                        minutelyRecords.append(minutelyRecord)
                        
                        let precipitation1 = value1.1.minutely[i].precipitation
                        precipitation.rain60Minutes.append(precipitation1)
                        
                    }
                    
                    //                    print("maxRain60Minutes = \(precipitation.maxRain60Minutes)")
                    //                    print("rain60Minutes = \(precipitation.rain60Minutes)")
                    
                    ///
                    ///  Finner antall minutter til regnet  begynner
                    ///
                    
                    for i in 0..<precipitation.rain60Minutes.count {
                        if precipitation.rain60Minutes[i] == 0.0 {
                            precipitation.minutesUntilRainStarts += 1
                        } else {
                            break
                        }
                    }
                    
                    ///
                    /// Finner antall minutter til regenet slutter
                    ///
                    
                    //        .refreshable {
                    //            await refreshCityRecordDetail()
                    //        }
                            

                    if precipitation.minutesUntilRainStarts <= precipitation.rain60Minutes.count {
                        for i in precipitation.minutesUntilRainStarts..<precipitation.rain60Minutes.count {
                            if precipitation.rain60Minutes[i] > 0.0 {
                                precipitation.minutesUntilRainStops += 1
                            } else {
                                precipitation.minutesUntilRainStops += precipitation.minutesUntilRainStarts
                                break
                            }
                        }
                    }
                    
                    ///
                    /// Henter Hourly forecast for 48 hours
                    ///
                    
                    precipitation.maxRain8Hours = 0.0
                    precipitation.maxTemperature = 0.00
                    hourlyRecords.removeAll()
                    hourlyRecords0.removeAll()
                    hourlyRecords1.removeAll()
                    hourlyRecords2.removeAll()
                    hourlyRecords0_compact.removeAll()
                    hourlyRecords1_compact.removeAll()
                    hourlyRecords2_compact.removeAll()
                    
                    precipitation.rain8Hours.removeAll()
                    
                    ///
                    /// HourlyRecords har kun 48 poster dvs.2 døgn
                    ///
                    /// Vurder å finne 5 døgn fremover
                    /// Se: api.openweathermap.org/data/2.5/forecast?q=London,us
                    ///
                    
                    var day = 0
                    
                    var sunrise = ""
                    var sunset = ""
                    var moon_phase = 0.00
                    var dt = ""
                    var lastDt = ""
                    var sectionHeader = ""
                    var sectionFooter = ""
                    var indexHourlyData = 0
                    
                    for i in 0..<48 {
                        let dt0 = (value1.1.hourly[i].dt)
                        dt = String(IntervalToWeekDay(interval: dt0))
                        if i == 0 {
                            lastDt = dt
                            sectionHeader = String(IntervalToDayDayMonth(interval: (value1.1.hourly[i].dt)).capitalizingFirstLetter())
                            indexHourlyData = 0
                            sectionFooter =  NSLocalizedString("Hour for hour", comment: "")
                            sunrise = String(IntervalToHourMin(interval: dailyRecords[day].sunrise))
                            sunset =  String(IntervalToHourMin(interval: dailyRecords[day].sunset))
                            moon_phase =  dailyRecords[day].moon_phase
                            day += 1
                        } else {
                            if dt != lastDt {
                                indexHourlyData += 1
                                sectionHeader = String(IntervalToDayDayMonth(interval: (value1.1.hourly[i].dt)).capitalizingFirstLetter())
                                lastDt = dt
                                sectionFooter = NSLocalizedString("Hour for hour", comment: "")
                                sunrise = String(IntervalToHourMin(interval: dailyRecords[day].sunrise))
                                sunset =  String(IntervalToHourMin(interval: dailyRecords[day].sunset))
                                moon_phase =  dailyRecords[day].moon_phase
                                day += 1
                            } else {
                                sunrise = ""
                                sunset = ""
                                moon_phase =  dailyRecords[day].moon_phase
                                sectionHeader = ""
                                sectionFooter = ""
                            }
                        }
                        
                        ///
                        /// Feilmelding: Type of expression is ambiguous without more context
                        ///
                        /// Årsak:     Eksempel:  let pop:  fra struct HourlyRecord:  var satt til feil type (Int istedet for Double
                        ///
                        
                        let hourlyRecord = HourlyRecord(sectionHeader:          sectionHeader,
                                                        sectionFooter:          sectionFooter,
                                                        indexHourlyData:        indexHourlyData,
                                                        sunrise:                sunrise,
                                                        sunset:                 sunset,
                                                        moon_phase:             moon_phase,
                                                        dt:                     (value1.1.hourly[i].dt),
                                                        temp:                   (value1.1.hourly[i].temp),
                                                        feels_like:             (value1.1.hourly[i].feels_like),
                                                        pressure:               (value1.1.hourly[i].pressure),
                                                        humidity:               (value1.1.hourly[i].humidity),
                                                        dew_point:              (value1.1.hourly[i].dew_point),
                                                        uvi:                    (value1.1.hourly[i].uvi),
                                                        clouds:                 (value1.1.hourly[i].clouds),
                                                        visibility:             (value1.1.hourly[i].visibility),
                                                        wind_speed:             (value1.1.hourly[i].wind_speed),
                                                        wind_deg:               (value1.1.hourly[i].wind_deg),
                                                        wind_gust:              (value1.1.hourly[i].wind_gust) ?? 0.00,
                                                        weather_id:             (value1.1.hourly[i].weather[0].id),
                                                        weather_main:           (value1.1.hourly[i].weather[0].main),
                                                        weather_description:    (value1.1.hourly[i].weather[0].description),
                                                        weather_icon:           (value1.1.hourly[i].weather[0].icon),
                                                        pop:                    (value1.1.hourly[i].pop),
                                                        rain:                   (value1.1.hourly[i].rain?.the1H) ?? 0.00,
                                                        snow:                   (value1.1.hourly[i].snow?.the1H) ?? 0.00)
                        
                        if hourlyRecord.sectionHeader != "" {
                            
                            if hourlyRecord.indexHourlyData == 0 {
                                hourlyRecords0.append(hourlyRecord)
                                imageInfo.sectionHeader0 = hourlyRecord.sectionHeader
                                imageInfo.sectionFooter0 = hourlyRecord.sectionFooter
                                imageInfo.moonPhase0 = hourlyRecord.moon_phase
                                imageInfo.sunRise0 = hourlyRecord.sunrise
                                imageInfo.sunSet0 = hourlyRecord.sunset
                            }
                            
                            if hourlyRecord.indexHourlyData == 1 {
                                hourlyRecords1.append(hourlyRecord)
                                imageInfo.sectionHeader1 = hourlyRecord.sectionHeader
                                imageInfo.sectionFooter1 = hourlyRecord.sectionFooter
                                imageInfo.moonPhase1 = hourlyRecord.moon_phase
                                imageInfo.sunRise1 = hourlyRecord.sunrise
                                imageInfo.sunSet1 = hourlyRecord.sunset
                            }
                            
                            if hourlyRecord.indexHourlyData == 2 {
                                hourlyRecords2.append(hourlyRecord)
                                imageInfo.sectionHeader2 = hourlyRecord.sectionHeader
                                imageInfo.sectionFooter2 = hourlyRecord.sectionFooter
                                imageInfo.moonPhase2 = hourlyRecord.moon_phase
                                imageInfo.sunRise2 = hourlyRecord.sunrise
                                imageInfo.sunSet2 = hourlyRecord.sunrise
                           }
                            
                        } else {
                            if hourlyRecord.indexHourlyData == 0 {
                                hourlyRecords0.append(hourlyRecord)
                            }
                            if hourlyRecord.indexHourlyData == 1 {
                                hourlyRecords1.append(hourlyRecord)
                            }
                            if hourlyRecord.indexHourlyData == 2 {
                                hourlyRecords2.append(hourlyRecord)
                            }
                        }
                        
                        hourlyRecords.append(hourlyRecord)
                        
                        if i < 8 {
                            let rain_Hour = (value1.1.hourly[i].rain?.the1H) ?? 0.00
                            precipitation.rain8Hours.append(rain_Hour)
                            if rain_Hour > precipitation.maxRain8Hours {
                                precipitation.maxRain8Hours = rain_Hour
                            }
                        }
                        if i == 8 {
                            //                            print("maxRain8Hours = \(precipitation.maxRain8Hours)")
                            //                            print("rain8Hours = \(precipitation.rain8Hours)")
                        }
                        
                        if (value1.1.hourly[i].temp) > precipitation.maxTemperature {
                            precipitation.maxTemperature = (value1.1.hourly[i].temp)
                        }
                        
                    } /// for
                    
                    ///
                    ///Oppdateter compact data
                    ///
                    
                    hourlyRecords0_compact = UpdateCompactHourlyRecords(index: 0,
                                                                        hr: hourlyRecords0)

                    hourlyRecords1_compact = UpdateCompactHourlyRecords(index: 1,
                                                                        hr: hourlyRecords1)

                    hourlyRecords2_compact = UpdateCompactHourlyRecords(index: 2,
                                                                        hr: hourlyRecords2)

                    ///
                    ///  Finner antall timer til regnet  begynner
                    ///
                    
                    for i in 0..<precipitation.rain8Hours.count {
                        if precipitation.rain8Hours[i] == 0.0 {
                            precipitation.hoursUntilRainStarts += 1
                        } else {
                            break
                        }
                    }
                    
                    ///
                    /// Finner antall timer til regnet slutter
                    ///
                    
                    if precipitation.hoursUntilRainStarts <= precipitation.rain8Hours.count {
                        for i in precipitation.hoursUntilRainStarts..<precipitation.rain8Hours.count {
                            if precipitation.rain8Hours[i] > 0.0 {
                                precipitation.hoursUntilRainStops += 1
                            } else {
                                precipitation.hoursUntilRainStops += precipitation.hoursUntilRainStarts
                                break
                            }
                        }
                    }
                    
                    //                    print("** precipitation.minutesUntilRainStarts: \(precipitation.minutesUntilRainStarts)")
                    //                    print("** precipitation.minutesUntilRainStops: \(precipitation.minutesUntilRainStops) \n\n")
                    //
                    //                    print("*** precipitation.hoursUntilRainStarts: \(precipitation.hoursUntilRainStarts)")
                    //                    print("*** precipitation.hoursUntilRainStops: \(precipitation.hoursUntilRainStops)")
                    
                    let cityRecord = value.1[0]
                    
                    var value5 : (LocalizedStringKey, WeatherDetail5Days)
                    await value5 = WeatherData5Days().getWeather5Days(cityRecord.lat,
                                                                      cityRecord.lon)
                    if value5.0 == "" {
                        
                        
                    } else {
                        title = NSLocalizedString("Error finding data ", comment: "refreshCityRecordDetail")
                        let msg1 = NSLocalizedString("Error finding data 5 Days for : ", comment: "refreshCityRecordDetail")
                        let msg2 = msg1 + "\(city)"
                        message = LocalizedStringKey(msg2)
                        isAlertActive.toggle()
                    }
                } else {
                    title = NSLocalizedString("Error finding data", comment: "refreshCityRecordDetail")
                    let msg1 = NSLocalizedString("Error finding data for :",  comment: "refreshCityRecordDetail")
                    let msg2 = msg1 + "\(city)"
                    message = LocalizedStringKey(msg2)
                    isAlertActive.toggle()
                }
            }
        }
    } // Task.init
} // refreshCityRecordDetail

func UpdateCompactHourlyRecords(index: Int,
                                hr: [HourlyRecord])  -> [HourlyRecord] {
    
    var hourlyRecords = [HourlyRecord]()
    let count = hr.count
    
    for i in 0..<count {
        switch i {
        case 0:
            hourlyRecords.append(hr[i])
        case 5:
            hourlyRecords.append(hr[i])
        case 11:
            hourlyRecords.append(hr[i])
        case 17:
            hourlyRecords.append(hr[i])
        case 23:
            hourlyRecords.append(hr[i])
        default:
            break
        }
    }
    
    ///
    /// Legge til siste posten dersom den ikke er vist tidligere
    ///
    
    let someSet = Set([0,5,11,17,23])
    let i = count - 1
    
    if !someSet.contains(i) {
        hourlyRecords.append(hr[i])
    }
    
    return hourlyRecords
}


