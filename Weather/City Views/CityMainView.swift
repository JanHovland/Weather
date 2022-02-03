//
//  Weather.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//
//  Xcode 13: 
//
//  Kommentar :  shift + control + command + / (tall tastaturet)
//  Innrykk:     shift + control + command + * (tall tastaturet)
//
//  Apple Developer Documentation: shift + command + 0 (tall tastaturet)
///
/// http://api.openweathermap.org/data/2.5/weather?q=London&appid={API key}
///

var apiKey = getApiKey()

import SwiftUI
import CloudKit
import Network

@MainActor

struct cityMainView: View {
    
    @State private var cityRecords = [CityRecord]()
    @State private var indexSetDelete = IndexSet()
    @State private var deletedCity: String = ""
    @State private var message: LocalizedStringKey = ""
    @State private var title: String = ""
    @State private var choise: String = ""
    @State private var device: String = ""

    @State private var indicatorShowing = false

    @State private var recordID: CKRecord.ID?
    
    let internetMonitor = NWPathMonitor()
    let internetQueue = DispatchQueue(label: "InternetMonitor")
    @State private var hasConnectionPath = false
    
    @State private var isAlertActive = false
    @State private var citySelectView = false
    
    @State private var searchFor = ""
    
    var body: some View {
        if apiKey.count == 32 {
            NavigationView {
                List {
                    HStack {
                        Spacer()
                        ActivityIndicator(isAnimating: $indicatorShowing, style: .medium, color: .gray)
                        Spacer()
                    }
                    .padding(.top, -10)
                    .padding(.bottom, -10)
                    ForEach(searchFor == "" ? cityRecords : cityRecords.filter { $0.city.starts(with: searchFor)}) { cityRecord in
                        NavigationLink(destination: cityDetailView(city: cityRecord.city)) {
                            cityRowView(cityRecord: cityRecord)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSetDelete = indexSet
                        recordID = cityRecords[indexSet.first!].recordID
                        cityRecords.removeAll()
                        Task.init {
                            await message = deleteCity(recordID!)
                            title = NSLocalizedString("Delete a city", comment: "")
                            isAlertActive.toggle()
                            ///
                            /// Viser resten av personene
                            ///
                            await refreshCityRecords()
                        }
                    })
                }
                .refreshable {
                    await refreshCityRecords()
                }
                .listStyle(InsetListStyle())
                .navigationBarTitle(Text("Weather overview"))
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        ControlGroup {
                            Button {
                                /// Rutine for å friske opp personoversikten
                                Task.init {
                                    await refreshCityRecords()
                                }
                            } label: {
                                Text("Refresh")
                                    .font(Font.headline.weight(.light))
                            }
                        }
                        .controlGroupStyle(.navigation)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            /// Rutine for å legge til et sted
                            citySelectView.toggle()
                        } label: {
                            Text("Add")
                                .font(Font.headline.weight(.light))
                        }
                        .sheet(isPresented: $citySelectView, content: {
                            CitySelectView(locationService: LocationService())
                        })
                    }
                })
                .alert(title, isPresented: $isAlertActive) {
                    Button("OK", action: {})
                } message: {
                    Text(message)
                }
                .task() {
                    /// Legger inn en forsinkelse på 1 sekund
                    /// Uten denne, kan det komme melding selv om Internett er tilhjengelig
                    sleep(1)
                    startInternetTracking()
                    ///
                    /// Må legge inn en forsinkelse fordi
                    /// usleep() takes millionths of a second
                    usleep(500000) /// 0.5 S
                    if hasInternet() == false {
                        if UIDevice.current.localizedModel == "iPhone" {
                            device = "iPhone"
                        } else if UIDevice.current.localizedModel == "iPad" {
                            device = "iPad"
                        }
                        title = device
                        let msg = NSLocalizedString("No Internet connection for this device.", comment: "")
                        message = LocalizedStringKey(msg)
                        isAlertActive.toggle()
                    } else {
                        if cityRecords.count == 0 {
                            indicatorShowing = true
                            await refreshCityRecords()
                            indicatorShowing = false
                        }
                    }
                    
                }
                .searchable(text: $searchFor, placement: .navigationBarDrawer, prompt: "Search...")
            }
        } else {
            OpenOfficeApiKey()
        }
    }
    
    func startInternetTracking() {
        // Only fires once
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
    }
    
    /// Will tell you if the device has an Internet connection
    /// - Returns: true if there is some kind of connection
    func hasInternet() -> Bool {
        return hasConnectionPath
    }
    
    /// Rutine for å friske opp bildet
    func refreshCityRecords() async {
        var value: (LocalizedStringKey, [CityRecord])
        cityRecords.removeAll()
        let predicate = NSPredicate(value: true)
        await value = findCitys(predicate)
        if value.0 != "" {
            message = value.0
            title = "Error message from the Server"
            isAlertActive.toggle()
        } else {
            cityRecords = value.1

        }
    } /// refreshCityRecords

}
