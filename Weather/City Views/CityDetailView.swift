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

struct CityDetailView: View {
    
    var city: String

    @ObservedObject var sheet = SettingsSheet()
    
    @ObservedObject private var weatherVM = WeatherViewModel()
    @ObservedObject private var weatherVMDetail = WeatherViewModelDetail()
//    @ObservedObject private var weatherVMDetailHour = WeatherViewModelDetailHour()
    
    @State private var dailyRecords = [DailyRecord]()
    @State private var hourlyRecords = [HourlyRecord]()
    @State private var minutelyRecords = [MinutelyRecord]()
    @State private var alertRecords = [AlertRecord]()
    
    @State private var alertButtonText = ""
    @State private var isRecordTapped: Bool = false
    
    @State private var i = 0
    
    @State private var precipitation = Precipitation(maxRain60Minutes: 0.00,
                                                     rain60Minutes: [Double](),
                                                     minutesUntilRainStarts: 0,
                                                     minutesUntilRainStops: 0,
                                                     startsWithRain60Minutes: 0,
                                                     maxRain8Hours: 0.00,
                                                     rain8Hours: [Double]().dropLast(),
                                                     maxTemperature: 0.00)
    
    ///
    /// Legg merke til CurrentRecord sine alerts_ felter alle er optional, så de trenger ikke initialiseres!
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
                                                     wind_gust: 0.0,
                                                     weather_id: 0,
                                                     weather_main: "",
                                                     weather_description: "",
                                                     weather_icon: "000")
    
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
                    
                    CityCurrentRecordTopView(currentRecord: $currentRecord)
                    
                    ///
                    /// Varsel fra Meteorologisk Institutt
                    ///
                    
                    if alertButtonText.count > 0 {
                        Button(action: {
                            alert_View()
                        })
                        {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                Text(NSLocalizedString(alertButtonText, comment: "CityDetailView"))
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
                    }
                    
                    ///
                    /// Ikke noe regn i løpet av de neste 8 timene
                    ///
                    
                    if precipitation.maxRain8Hours ==  0.00 {
                        Text(NSLocalizedString("No precipitation for the next 8 hours", comment: "CityDetailView"))
                            .font(.system(size: 13, weight: .regular))
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                    } else {
                        PrecipitationStatus(minutesUntilRainStarts: $precipitation.minutesUntilRainStarts,
                                            minutesUntilRainStops: $precipitation.minutesUntilRainStops)
                            .font(.system(size: 13, weight: .regular))
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                    }
                }
                
                ///
                /// Oversikt diverse værdata
                ///
                
                VStack {
                    HStack {
                        HStack {
                            Text("Wind: ")
                            Text(String(format:"%.1f", currentRecord.wind_speed) + " m/s")
                            Text(WindDirection(deg: currentRecord.wind_deg))
                            Image("Arrow_north")
                                .resizable()
                                .frame(width: 40 , height: 40, alignment: .center)
                                .rotationEffect(Angle(degrees: Double(currentRecord.wind_deg)), anchor: .center)
                                .padding(.top, -5)
                                .padding(.leading, -10)
                        }
                        Spacer()
                        HStack {
                            Text("Humidity: ")
                            Text("\(currentRecord.humidity)%")
                        }
                    }
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
                    
                    .padding(.top, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                    
                    ///
                    /// Data for test av PrecipitationStatus()
                    ///
                    
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
                    
                }
                .font(.system(size: 13, weight: .regular))
                /// Egendefinert farge Assets.xcassets
                .background(Color("Background"))
                .cornerRadius(20)
                
                ///
                /// Oversikt nedbør
                ///
                
                VStack (alignment: .leading) {
                    if precipitation.maxRain60Minutes != 0.00 {
                        Text(String(format:"%.1f", precipitation.maxRain60Minutes))
                            .font(.system(size: 13, weight: .regular))
                        CityLineViewMinutes(precipitation: $precipitation,
                                            minutelyRecords: $minutelyRecords)
                              .padding(.leading, 20)
                    } else if precipitation.maxRain8Hours != 0.00 {
                        Text(String(format:"%.1f", precipitation.maxRain8Hours))
                            .font(.system(size: 13, weight: .regular))
                        CityLineViewHours(precipitation: $precipitation,
                                          hourlyRecords: $hourlyRecords)
                            .padding(.leading, 20)
                    }
                }
                
                ///
                /// Oversikt over de neste 48 timene
                ///
                
                CityHourly48HourView(hourlyRecords: $hourlyRecords)

            }
        }
        .onAppear() {
            UITableView.appearance().showsVerticalScrollIndicator = false
            refreshCityRecordDetail()
            print("Modellens bredde = \(UIScreen.screenWidth)")
            print("Modellens høyde = \(UIScreen.screenHeight)")
        }
        .sheet(isPresented: $sheet.isShowing, content: sheetContent)
        .navigationBarTitle((currentRecord.weather_icon != "000") ?  city : "")
    }
    
    /// Her legges det inn knytning til aktuelle view
    @ViewBuilder
    private func sheetContent() -> some View {
        if sheet.state == .alertView {
            CityAlertView(alertRecords: alertRecords)
        } else {
            EmptyView()
        }
    }
    
    func alert_View() {
        sheet.state = .alertView
    }
    
    /// Rutine for å finn vær detaljene
    func refreshCityRecordDetail() {
        
        var rainDaily: Double = 0.0
        var rainCurrent: Double = 0.0
        
        var snowDaily: Double = 0.0
        var snowCurrent: Double = 0.0
        
        var wind_gustDaily: Double = 0.0
        var wind_gustCurrent: Double = 0.0
        
        var wind_gustHour: Double = 0.0
        var rain_Hour: Double = 0.0
        var snow_Hour: Double = 0.0
        
        var numberHourdataFirstDay = 0

        var alerts_sender_name = ""
        var alerts_event = ""
        var alerts_start = 0
        var alerts_end = 0
        var alerts_description = ""
        
        var numberOfAlerts = 0
        
        var sectionHeading = ""
        var dt = ""
        var lastDt = ""
        
        let predicate = NSPredicate(format: "city = %@", city)
        CloudKitCityRecord.fetchCityRecord(predicate: predicate)  { (result) in
            switch result {
            case .success(let cityRecord):
                DispatchQueue.main.async {
                    WeatherServiceDetail().getWeatherDetail(lat: cityRecord.lat,
                                                            lon: cityRecord.lon) { res in
                        switch res {
                        case .success(let weatherDetail) :
                            
                            dailyRecords.removeAll()
                            
                            ///
                            /// Daily forecast for 7 days + i dag
                            ///
                            
                            for i in 0...7 {
                                ///
                                /// Håndterer det tilfellet at wind_gust, rain og snow er nil (mangler eller har ingen verdi)
                                ///
                                if weatherDetail?.daily[i].wind_gust == nil {
                                    wind_gustDaily = 0.00
                                } else {
                                    wind_gustDaily = (weatherDetail?.daily[i].wind_gust)!
                                }
                                
                                if weatherDetail?.daily[i].rain == nil {
                                    rainDaily = 0.00
                                } else {
                                    rainDaily = (weatherDetail?.daily[i].rain)!
                                }
                                
                                if weatherDetail?.daily[i].snow == nil {
                                    snowDaily = 0.00
                                } else {
                                    snowDaily = (weatherDetail?.daily[i].snow)!
                                }
                                
                                let dailyRec = DailyRecord(index:               i,
                                                           dt:                  (weatherDetail?.daily[i].dt)!,
                                                           sunrise:             (weatherDetail?.daily[i].sunrise)!,
                                                           sunset:              (weatherDetail?.daily[i].sunset)!,
                                                           moonrise:            (weatherDetail?.daily[i].moonrise)!,
                                                           moonset:             (weatherDetail?.daily[i].moonset)!,
                                                           moon_phase:          (weatherDetail?.daily[i].moon_phase)!,
                                                           temp_day:            (weatherDetail?.daily[i].temp.day)!,
                                                           temp_min:            (weatherDetail?.daily[i].temp.min)!,
                                                           temp_max:            (weatherDetail?.daily[i].temp.max)!,
                                                           temp_night:          (weatherDetail?.daily[i].temp.night)!,
                                                           temp_eve:            (weatherDetail?.daily[i].temp.eve)!,
                                                           temp_morn:           (weatherDetail?.daily[i].temp.morn)!,
                                                           feels_like_day:      (weatherDetail?.daily[i].feels_like.day)!,
                                                           feels_like_night:    (weatherDetail?.daily[i].feels_like.night)!,
                                                           feels_like_eve:      (weatherDetail?.daily[i].feels_like.eve)!,
                                                           feels_like_morn:     (weatherDetail?.daily[i].feels_like.morn)!,
                                                           pressure:            (weatherDetail?.daily[i].pressure)!,
                                                           humidity:            (weatherDetail?.daily[i].humidity)!,
                                                           dew_point:           (weatherDetail?.daily[i].dew_point)!,
                                                           wind_speed:          (weatherDetail?.daily[i].wind_speed)!,
                                                           wind_gust:           wind_gustDaily,
                                                           wind_deg:            (weatherDetail?.daily[i].wind_deg)!,
                                                           weather_id:          (weatherDetail?.daily[i].weather[0].id)!,
                                                           weather_main:        (weatherDetail?.daily[i].weather[0].main)!,
                                                           weather_description: (weatherDetail?.daily[i].weather[0].description)!,
                                                           weather_icon:        (weatherDetail?.daily[i].weather[0].icon)!,
                                                           clouds:              (weatherDetail?.daily[i].clouds)!,
                                                           pop:                 (weatherDetail?.daily[i].pop)!,
                                                           rain_the1h:          rainDaily,
                                                           snow_the1h:          snowDaily,
                                                           uvi:                 (weatherDetail?.daily[i].uvi)!)
                                
                                dailyRecords.append(dailyRec)
                            }
                            ///
                            /// Håndterer det tilfellet at windgust, rain og snoe nil (mangler eller har ingen verdi)
                            ///
                            if weatherDetail?.current.wind_gust == nil {
                                wind_gustCurrent = 0.00
                            } else {
                                wind_gustCurrent = (weatherDetail?.current.wind_gust)!
                            }
                            
                            if weatherDetail?.current.rain?.the1H == nil {
                                rainCurrent = 0.00
                            } else {
                                rainCurrent = (weatherDetail?.current.rain?.the1H)!
                            }
                            
                            if weatherDetail?.current.snow?.the1H == nil {
                                snowCurrent = 0.00
                            } else {
                                snowCurrent = (weatherDetail?.current.snow?.the1H)!
                            }
                            
                            if weatherDetail?.alerts?[0].sender_name == nil {
                                alerts_sender_name = ""
                            } else {
                                alerts_sender_name = (weatherDetail?.alerts![0].sender_name)!
                            }
                            
                            currentRecord = CurrentRecord(dt:                  (weatherDetail?.current.dt)!,
                                                          sunrise:             (weatherDetail?.current.sunset)!,
                                                          sunset:              (weatherDetail?.current.sunset)!,
                                                          temp:                (weatherDetail?.current.temp)!,
                                                          feels_like:          (weatherDetail?.current.feels_like)!,
                                                          pressure:            (weatherDetail?.current.pressure)!,
                                                          humidity:            (weatherDetail?.current.humidity)!,
                                                          dew_point:           (weatherDetail?.current.dew_point)!,
                                                          uvi:                 (weatherDetail?.current.uvi)!,
                                                          clouds:              (weatherDetail?.current.clouds)!,
                                                          visibility:          (weatherDetail?.current.visibility)!,
                                                          wind_speed:          (weatherDetail?.current.wind_speed)!,
                                                          wind_deg:            (weatherDetail?.current.wind_deg)!,
                                                          wind_gust:           wind_gustCurrent,
                                                          rain_the1h:          rainCurrent,
                                                          snow_the1h:          snowCurrent,
                                                          weather_id:          (weatherDetail?.current.weather[0].id)!,
                                                          weather_main:        (weatherDetail?.current.weather[0].main)!,
                                                          weather_description: (weatherDetail?.current.weather[0].description)!,
                                                          weather_icon:        (weatherDetail?.current.weather[0].icon)!)
                            
                            alertRecords.removeAll()
                            
                            if weatherDetail?.alerts?[0].event != nil {
                                numberOfAlerts = (weatherDetail?.alerts?.count)!
                            }
                            
                            //                            print("numberOfAlerts: \(numberOfAlerts)")
                            
                            for i in 0..<numberOfAlerts {
                                
                                if weatherDetail?.alerts?[i].event == nil {
                                    alerts_event = ""
                                } else {
                                    alerts_event = (weatherDetail?.alerts![i].event)!
                                    if alerts_event == "Snow" {
                                        alerts_event =  NSLocalizedString("Snow", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Gale", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Thunderstorm", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Drizzle", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Atmosphere", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Clear", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Clouds", comment: "refreshCityRecordDetail")
                                    }
                                }
                                
                                if weatherDetail?.alerts?[i].start == nil {
                                    alerts_start = 0
                                } else {
                                    alerts_start = (weatherDetail?.alerts![i].start)!
                                }
                                
                                if weatherDetail?.alerts?[i].end == nil {
                                    alerts_end  = 0
                                } else {
                                    alerts_end  = (weatherDetail?.alerts![i].end)!
                                }
                                
                                if weatherDetail?.alerts?[i].description == nil {
                                    alerts_description  = ""
                                } else {
                                    alerts_description  = (weatherDetail?.alerts![i].description)!
                                }
                                
                                let alertRecord = AlertRecord(sender_name:  alerts_sender_name,
                                                              event:        alerts_event,
                                                              start:        alerts_start,
                                                              end:          alerts_end,
                                                              description:  alerts_description)
                                
                                alertRecords.append(alertRecord)
                                if numberOfAlerts == 1 {
                                    alerts_event = (weatherDetail?.alerts![0].event)!
                                    if alerts_event == "Snow" {
                                        alerts_event =  NSLocalizedString("Snow", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Gale", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Thunderstorm", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Drizzle", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Atmosphere", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Clear", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Clouds", comment: "refreshCityRecordDetail")
                                    }
                                    alertButtonText = alerts_event
                                } else {
                                    alerts_event = (weatherDetail?.alerts![0].event)!
                                    if alerts_event == "Snow" {
                                        alerts_event =  NSLocalizedString("Snow", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Gale", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Thunderstorm", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Drizzle", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Atmosphere", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Clear", comment: "refreshCityRecordDetail")
                                    } else if alerts_event == "Gale" {
                                        alerts_event =  NSLocalizedString("Clouds", comment: "refreshCityRecordDetail")
                                    }
                                    alertButtonText = alerts_event + " + \(numberOfAlerts - 1)"
                                }
                            }
                            
                            ///
                            /// Henter Minute forecast for 1 hour
                            ///
 
                            precipitation.maxRain60Minutes = 0.0
                            minutelyRecords.removeAll()
                            precipitation.rain60Minutes.removeAll()

                            for i in 0...59 {
                                let minutelyRecord = MinutelyRecord(dt:            (weatherDetail?.minutely[i].dt)!,
                                                                    precipitation: (weatherDetail?.minutely[i].precipitation)!)
                                
                                if minutelyRecord.precipitation > precipitation.maxRain60Minutes {
                                    precipitation.maxRain60Minutes = minutelyRecord.precipitation
                                }
                                
                                minutelyRecords.append(minutelyRecord)
                                
                                let precipitation1 = weatherDetail?.minutely[i].precipitation
                                precipitation.rain60Minutes.append(precipitation1!)
                                
                            }
                            
                            print("maxRain60Minutes = \(precipitation.maxRain60Minutes)")
                            print("rain60Minutes = \(precipitation.rain60Minutes)")
                            
                            ///
                            ///  Finner antall minutter til regnet stopper / begynner
                            ///
                            
                            if precipitation.rain60Minutes.count > 0 {
                                for i in 0..<precipitation.rain60Minutes.count {
                                    if i == 0 {
                                        if precipitation.rain60Minutes[i] == 0.0 {
                                            self.precipitation.startsWithRain60Minutes = 0
                                        } else {
                                            self.precipitation.startsWithRain60Minutes = 1
                                        }
                                    } else {
                                        if precipitation.startsWithRain60Minutes == 0 {
                                            if precipitation.rain60Minutes[i] == 0.0 {
                                                precipitation.minutesUntilRainStarts += 1
                                            } else {
                                                break
                                            }
                                        } else {
                                            if precipitation.rain60Minutes[i] == 0.0 {
                                                precipitation.minutesUntilRainStops += 1
                                                break
                                            }
                                        }
                                    }
                                }
                            }
                            
                            if precipitation.minutesUntilRainStarts == 59 {
                                precipitation.minutesUntilRainStarts = 60
                            }
                            
                            if precipitation.minutesUntilRainStops == 59 {
                                precipitation.minutesUntilRainStops = 60
                            }
                            
                            ///
                            /// Henter Hourly forecast for 48 hours
                            ///
                            
                            precipitation.maxRain8Hours = 0.0
                            precipitation.maxTemperature = 0.00
                            hourlyRecords.removeAll()
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
                            
                            for i in 0..<48 {
                                dt = String(IntervalToWeekDay(interval: (weatherDetail?.hourly[i].dt)!))
                                
                                if i == 0 {
                                    lastDt = dt
                                    sectionHeading = "I dag " + String(IntervalToCompleteDayNameOfWeek(interval: (weatherDetail?.hourly[i].dt)!))
                                    sunrise = String(IntervalToHourMin(interval: dailyRecords[day].sunrise))
                                    sunset =  String(IntervalToHourMin(interval: dailyRecords[day].sunset))
                                    print(sunrise)
                                    print(sunset)
                                    day += 1
                                } else {
                                    
                                    if dt != lastDt {
                                        sectionHeading = String(IntervalToCompleteDayNameOfWeek(interval: (weatherDetail?.hourly[i].dt)!).capitalizingFirstLetter())
                                        lastDt = dt
                                        sunrise = String(IntervalToHourMin(interval: dailyRecords[day].sunrise))
                                        sunset =  String(IntervalToHourMin(interval: dailyRecords[day].sunset))
                                        print(sunrise)
                                        print(sunset)
                                        day += 1
                                    } else {
                                        sunrise = ""
                                        sunset = ""
                                        sectionHeading = ""
                                    }
                                }
                                
                                ///
                                /// Håndterer det tilfellet at wind_gust, rain og snow er nil (mangler eller har ingen verdi)
                                ///
                                
                                if weatherDetail?.hourly[i].wind_gust == nil {
                                    wind_gustHour = 0.00
                                } else {
                                    wind_gustHour = (weatherDetail?.hourly[i].wind_gust)!
                                }
                                
                                if weatherDetail?.hourly[i].rain?.the1H == nil {
                                    rain_Hour = 0.00
                                } else {
                                    rain_Hour = (weatherDetail?.hourly[i].rain?.the1H)!
                                }
                                
                                if weatherDetail?.hourly[i].snow?.the1H == nil {
                                    snow_Hour = 0.00
                                } else {
                                    snow_Hour = (weatherDetail?.hourly[i].snow?.the1H)!
                                }
                                
                                numberHourdataFirstDay = 0
                                
                                ///
                                /// Type of expression is ambiguous without more context
                                ///
                                /// Årsak:     Eksempel:  let pop:  fra struct HourlyRecord:  var satt til feil type (Int istedet for Double
                                ///
                                
                                let hourlyRecord = HourlyRecord(sectionHeading:         sectionHeading,
                                                                sunrise:                sunrise,
                                                                sunset:                 sunset,
                                                                dt:                     (weatherDetail?.hourly[i].dt)!,
                                                                numberHourdataFirstDay: numberHourdataFirstDay,
                                                                temp:                   (weatherDetail?.hourly[i].temp)!,
                                                                feels_like:             (weatherDetail?.hourly[i].feels_like)!,
                                                                pressure:               (weatherDetail?.hourly[i].pressure)!,
                                                                humidity:               (weatherDetail?.hourly[i].humidity)!,
                                                                dew_point:              (weatherDetail?.hourly[i].dew_point)!,
                                                                uvi:                    (weatherDetail?.hourly[i].uvi)!,
                                                                clouds:                 (weatherDetail?.hourly[i].clouds)!,
                                                                visibility:             (weatherDetail?.hourly[i].visibility)!,
                                                                wind_speed:             (weatherDetail?.hourly[i].wind_speed)!,
                                                                wind_deg:               (weatherDetail?.hourly[i].wind_deg)!,
                                                                wind_gust:              wind_gustHour,
                                                                weather_id:             (weatherDetail?.hourly[i].weather[0].id)!,
                                                                weather_main:           (weatherDetail?.hourly[i].weather[0].main)!,
                                                                weather_description:    (weatherDetail?.hourly[i].weather[0].description)!,
                                                                weather_icon:           (weatherDetail?.hourly[i].weather[0].icon)!,
                                                                pop:                    (weatherDetail?.hourly[i].pop)!,
                                                                rain:                   rain_Hour,
                                                                snow:                   snow_Hour)
                                
                                hourlyRecords.append(hourlyRecord)
                                if i < 8 {
                                    precipitation.rain8Hours.append(rain_Hour)
                                    if rain_Hour > precipitation.maxRain8Hours {
                                        precipitation.maxRain8Hours = rain_Hour
                                    }
                                }
                                if i == 8 {
                                    print("maxRain8Hours = \(precipitation.maxRain8Hours)")
                                    print("rain8Hours = \(precipitation.rain8Hours)")
                                }
                                
                                if (weatherDetail?.hourly[i].temp)! > precipitation.maxTemperature {
                                    precipitation.maxTemperature = (weatherDetail?.hourly[i].temp)!
                                }
                                
                            } /// for
                        case .failure(let err ) :
                            print("Fra currentRecord: \(err.localizedDescription) Sted: \(city)")
                        }
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    } /// refreshCityRecordDetail()
    
    /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-return-different-view-types
    
    struct PrecipitationStatus: View {
        
        @Binding var minutesUntilRainStarts: Int
        @Binding var minutesUntilRainStops: Int
        
        var body: some View {
            if minutesUntilRainStarts > 0 {
                let msg = NSLocalizedString("No Precipitation for the next ", comment: "PrecipitationStatus")
                let msg1 = NSLocalizedString(" minutes", comment: "PrecipitationStatus")
                Text(msg + "\(minutesUntilRainStarts)" + msg1)
            }
            if minutesUntilRainStops > 0 {
                let msg = NSLocalizedString("Precipitation will stop in ", comment: "PrecipitationStatus")
                let msg1 = NSLocalizedString(" minutes", comment: "PrecipitationStatus")
                Text(msg + "\(minutesUntilRainStops)" + msg1)
            }
        }
    }
    
}

