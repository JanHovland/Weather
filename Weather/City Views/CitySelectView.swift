//
//  CitySelectView.swift
//  Weather
//
//  Created by Jan Hovland on 15/03/2021.
//

import SwiftUI
import CloudKit

struct CitySelectView: View, Sendable {
    
    @ObservedObject var locationService: LocationService
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var message: LocalizedStringKey = ""
    @State private var title: String = ""
    @State private var choise: String = ""
    @State private var result: String = ""
    @State private var city: String = ""
    @State private var recordID: String = ""
    
    @State private var isAlertActive = false
    
    var weatherServiceCoordinate = WeatherServiceCoordinate()
   
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .font(Font.headline.weight(.light))
                })
                Spacer()
            }
            .padding(.top, 20)
            .padding(.leading, 15)
            .padding(.bottom, -10)
            HStack {
                Text("Add City")
                    .font(.system(size: 34, weight: .bold))
                Spacer()
            }
            .padding()
            List {
                Section(header: Text("Location Search")) {
                    ZStack(alignment: .trailing) {
                        TextField("Search", text: $locationService.queryFragment)
                        // This is optional and simply displays an icon during an active search
                        if locationService.status == .isSearching {
                            Image(systemName: "clock")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                Section(header: Text("Results")) {
                    ForEach(locationService.searchResults , id: \.self) { completionResult in
                        VStack {
                            HStack {
                                HStack{
                                    VStack (alignment: .leading) {
                                        Text(completionResult.title)
                                        Text(completionResult.subtitle)
                                            .padding(.bottom, 10)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text("Save")
                                        .foregroundColor(Color(.systemRed))
                                        .onTapGesture {
                                            ///
                                            /// Sjekk om city finnes fra før
                                            ///
                                            Task.init {
                                                city = completionResult.title
                                                let value: (LocalizedStringKey, CKRecord.ID?)
                                                let predicate = NSPredicate(format: "city = %@", city)
                                                await value = cityRecordId(predicate)
                                                if value.0 != "" {
                                                    ///
                                                    ///Feilmelding
                                                    ///
                                                    message = value.0
                                                    title = NSLocalizedString("Error message from the Server", comment: "CitySelectView")
                                                    isAlertActive.toggle()
                                                } else {
                                                    if value.1 == nil {
                                                        
                                                        ///
                                                        ///Finn koordinatene
                                                        ///
                                                        
                                                        var value : (LocalizedStringKey, WeatherCoordinates)
                                                        await value = weatherServiceCoordinate.getCoordinates(city)
                                                        if value.0 == "" {
                                                            let cityRecord = CityRecord(recordID: nil,
                                                                                        lat: value.1.coord.lat,
                                                                                        lon: value.1.coord.lon,
                                                                                        city: city)
                                                            Task.init {
                                                                await message = saveCity(cityRecord)
                                                                title = NSLocalizedString("Save city", comment: "CitySelectView")
                                                                isAlertActive.toggle()
                                                            }
                                                        } else {
                                                            let msg = NSLocalizedString("Error saving city", comment: "CitySelectView")
                                                            message = LocalizedStringKey(msg)
                                                            title = NSLocalizedString("Save city", comment: "CitySelectView")
                                                            isAlertActive.toggle()
                                                        }
                                                    } else {
                                                        let msg = NSLocalizedString("This city exists in CloudKit ", comment: "CitySelectView")
                                                        message = LocalizedStringKey(msg)
                                                        title = NSLocalizedString("Save", comment: "CitySelectView")
                                                        isAlertActive.toggle()
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .alert(title, isPresented: $isAlertActive) {
                Button("OK", action: {})
            } message: {
                Text(message)
            }
        } // VStack
    }
    
}
