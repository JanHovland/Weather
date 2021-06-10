//
//  Weather.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//
//  Xcode 13: 
//
//  Kommentar :  command + ´ ( venstre for slett)
//  Innrykk:     shift + control + command + 8 (tall tastaturet)
//
//  Apple Developer Documentation: shift + command + 0 (tall tastaturet)
//

///
/// http://api.openweathermap.org/data/2.5/weather?q=London&appid={API key}
///

// let apiKey = "{API key}"
let apiKey = "f250e7938c2239c25a356a30167d214d"

import SwiftUI
import CloudKit
import Network

struct CityMainView: View {
    
    @ObservedObject private var weatherVM = WeatherViewModel()    
    @ObservedObject var sheet = SettingsSheet()
    
    @State private var cityRecords = [CityRecord]()
    @State private var selectedRecordId: CKRecord.ID?
    @State private var indexSetDelete = IndexSet()
    @State private var deletedCity: String = ""
    @State private var message: String = ""
    @State private var hudMessage: String = ""

    @State private var title: String = ""
    @State private var choise: String = ""
    @State private var alertIdentifier: AlertID?

    let internetMonitor = NWPathMonitor()
    let internetQueue = DispatchQueue(label: "InternetMonitor")
    @State private var hasConnectionPath = false
    @State private var device = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(NSLocalizedString("Your Cities", comment: "MainWeatherView"))) {
                    ForEach(cityRecords) { cityRecord in
                        NavigationLink(destination: CityDetailView(city: cityRecord.city)) {
                            CityRowView(cityRecord: cityRecord)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSetDelete = indexSet
                        selectedRecordId = cityRecords[indexSet.first!].recordID
                        let city = cityRecords[indexSet.first!].city
                        let msg = NSLocalizedString("Delete + e ", comment: "MainWeatherView")
                        title = msg + city + "?"
                        message = ""
                        let msg1 = NSLocalizedString("Delete ", comment: "MainWeatherView")
                        choise = msg1 + city
                        deletedCity = city
                        alertIdentifier = AlertID(id: .delete)
                    })
                }
            }
            .listStyle(InsetListStyle())           /// GroupedListStyle())
            .navigationBarTitle(Text(NSLocalizedString("Weather", comment: "MainWeatherView")))
            .navigationBarItems(leading:
                                    Button(action: {
                                        /// Rutine for å friske opp personoversikten
                                        refreshCityRecords()
                                    }, label: {
                                        Text("Refresh")
                                            .font(Font.headline.weight(.light))
                                    })
                                , trailing:
                                    Button(action: {
                                        /// Rutine for å legge til et sted
                                        sheet.state = .cityView
                                    }, label: {
                                        Text(NSLocalizedString("Add", comment: "MainWeatherView"))
                                            .font(Font.headline.weight(.light))
                                    })
            )
            .sheet(isPresented: $sheet.isShowing, content: sheetContent)
            .onAppear() {
                /// Legger inn en forsinkelse på 1 sekund
                /// Uten denne, kan det komme melding selv om Internett er tilhjengelig
                sleep(1)
                startInternetTracking()
                refreshCityRecords()
            }
            .alert(item: $alertIdentifier) { alert in
                switch alert.id {
                case .first:
                    return Alert(title: Text(message))
                case .second:
                    return Alert(title: Text(message))
                case .third:
                    return Alert(title: Text(message))
                case .delete:
                    return Alert(title: Text(title),
                                 message: Text(message),
                                 primaryButton: .destructive(Text(choise),
                                                             action: {
                                                                CloudKitCityRecord.deleteCityRecord(recordID: selectedRecordId!) { (result) in
                                                                    switch result {
                                                                    case .success :
                                                                        let msg =  NSLocalizedString("Successfully deleted ", comment: "MainWeatherView")
                                                                        message =  msg + deletedCity
                                                                        hudMessage = message
                                                                        sheet.state = .hudView
                                                                    case .failure(let err):
                                                                        message = err.localizedDescription
                                                                        alertIdentifier = AlertID(id: .first)
                                                                    }
                                                                }
                                                                /// Sletter den valgte raden i iOS
                                                                cityRecords.remove(atOffsets: indexSetDelete)
                                                                
                                                             }),
                                 secondaryButton: .default(Text(NSLocalizedString("Cancel", comment: "MainWeatherView"))))
                case .save:
                    return Alert(title: Text(message))
                }
            }
        }
    }

    func startInternetTracking() {
        /// Only fires once
        guard internetMonitor.pathUpdateHandler == nil else {
            return
        }
        internetMonitor.pathUpdateHandler = { update in
            if update.status == .satisfied {
                self.hasConnectionPath = true
            } else {
                self.hasConnectionPath = false
            }
        }
        internetMonitor.start(queue: internetQueue)
        #if os(iOS)
        /// Legger inn en forsinkelse på 1 sekund
        /// Uten denne, kan det komme melding selv om Internett er tilhjengelig
        sleep(1)
        if hasInternet() == false {
            if UIDevice.current.localizedModel == "iPhone" {
                device = "iPhone"
            } else if UIDevice.current.localizedModel == "iPad" {
                device = "iPad"
            }
            let message1 = NSLocalizedString("No Internet connection for this ", comment: "SignInView")
            message = message1 + device + "."
            alertIdentifier = AlertID(id: .first)
        }
        #endif
    }

    
    /// Will tell you if the device has an Internet connection
    /// - Returns: true if there is some kind of connection
    func hasInternet() -> Bool {
        return hasConnectionPath
    }
    
    @ViewBuilder
    private func sheetContent() -> some View {
        if sheet.state == .cityView {
            CitySelectView(locationService: LocationService())
        } else if sheet.state == .hudView {
            HudView(hudMessage: hudMessage)
        } else {
            EmptyView()
        }
    }
    
    /// Rutine for å friske opp bildet
    func refreshCityRecords() {
        /// Sletter alt tidligere innhold i cityRecords
        cityRecords.removeAll()
        let predicate = NSPredicate(value: true)
        /// Finner første alle postene
        CloudKitCityRecord.fetchCityRecord(predicate: predicate)  { (result) in
            switch result {
            case .success(let cityRecord):
                DispatchQueue.main.async {
                    cityRecords.append(cityRecord)
                    cityRecords.sort(by: {$0.city < $1.city})
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        /// Oppdaterer deretter data fra weatherVM
        /// Dette ser ut til å være den rette måten å gjøre det på, siden jeg får problem med å
        /// kalle weatherVM.fetchWeather(city: cityRecord.city) overfor!!!!
        CloudKitCityRecord.fetchCityRecord(predicate: predicate)  { (result) in
            switch result {
            case .success(let cityRecord):
                DispatchQueue.main.async {
                    weatherVM.fetchWeather(city: cityRecord.city)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    } /// refreshCityRecords

}

