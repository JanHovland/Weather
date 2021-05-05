//
//  CitySelectView.swift
//  Weather
//
//  Created by Jan Hovland on 15/03/2021.
//

import SwiftUI

struct CitySelectView: View {
    
    @ObservedObject var locationService: LocationService
    @ObservedObject private var weatherVM = WeatherViewModel()
   
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var sheet = SettingsSheet()
    
    @State private var message: String = ""
    @State private var hudMessage: String = ""
    @State private var title: String = ""
    @State private var choise: String = ""
    @State private var result: String = ""
    @State private var alertIdentifier: AlertID?
    @State private var city: String = ""
    @State private var recordID: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(NSLocalizedString("Cancel", comment: "CitySelectView"))
                        .font(Font.headline.weight(.light))
                })
                Spacer()
            }
            .padding(.top, 20)
            .padding(.leading, 15)
            .padding(.bottom, -10)
            HStack {
                Text(NSLocalizedString("Add City", comment: "CitySelectView"))
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
                                    Text(NSLocalizedString("Save", comment: "CitySelectView"))
                                        .foregroundColor(Color(.systemRed))
                                        .onTapGesture {
                                            ///
                                            /// Sjekk om city finnes fra før
                                            ///
                                            CloudKitCityRecord.doesCityRecordExist(city: completionResult.title) { (res) in
                                                if res == false  {
                                                    city = completionResult.title
                                                    let msg = NSLocalizedString("Save ", comment: "CitySelectView")
                                                    title = msg + city
                                                    let msg1 = NSLocalizedString("Are you sure you want to save ", comment: "CitySelectView")
                                                    message = msg1 + city + "?"
                                                    choise = NSLocalizedString("Save this City", comment: "CitySelectView")
                                                    let msg2 = NSLocalizedString("Successfully saved ", comment: "CitySelectView")
                                                    result = msg2 + city
                                                    alertIdentifier = AlertID(id: .save)
                                                } else {
                                                    let msg = NSLocalizedString(" already exists.", comment: "CitySelectView")
                                                    message = completionResult.title + msg
                                                    alertIdentifier = AlertID(id: .first)
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
            .sheet(isPresented: $sheet.isShowing, content: sheetContent)
            .alert(item: $alertIdentifier) { alert in
                switch alert.id {
                case .first:
                    return Alert(title: Text(message))
                case .second:
                    return Alert(title: Text(message))
                case .third:
                    return Alert(title: Text(message))
                case  .delete:
                    return Alert(title: Text(message))
                case .save:
                    return Alert(title: Text(title),
                                 message: Text(message),
                                 primaryButton: .destructive(Text(choise),
                                                             action: {
                                                                WeatherService().getWeather(city: city) { result in
                                                                    switch result {
                                                                    case .success(let weatherInfo) :
                                                                        let temp1 = (weatherInfo?.main.temp)!
                                                                        let temp = round(temp1 - 273.15)*10/10
                                                                        let cityRecord = CityRecord(recordID: nil,
                                                                                                    lat: (weatherInfo?.coord.lat)!,
                                                                                                    lon: (weatherInfo?.coord.lon)!,
                                                                                                    city: city,
                                                                                                    icon: (weatherInfo?.weather[0].icon)!,
                                                                                                    temp: temp,
                                                                                                    description: (weatherInfo?.weather[0].description)!,
                                                                                                    deg: (weatherInfo?.wind.deg)!)
                                                                        
                                                                        CloudKitCityRecord.saveCityRecord(cityRecord: cityRecord) { (result) in
                                                                            switch result {
                                                                            case .success:
                                                                                let msg = NSLocalizedString(" is saved in CloudKit.", comment: "CitySelectView")
                                                                                message = city + msg
                                                                                hudMessage = message
                                                                                sheet.state = .hudView
//                                                                                alertIdentifier = AlertID(id: .first) // HUD //
                                                                            case .failure(let err):
                                                                                message = err.localizedDescription
                                                                                alertIdentifier = AlertID(id: .first)
                                                                            }
                                                                        }
                                                                    case .failure(let err ) :
                                                                        print(err.localizedDescription)
                                                                    }
                                                                }
                                                             }),
                                 secondaryButton: .default(Text(NSLocalizedString("Cancel", comment: "CitySelectView"))))
                }
            }
        }
    }
    
    /// Her legges det inn knytning til aktuelle view
    @ViewBuilder
    private func sheetContent() -> some View {
        if sheet.state == .hudView {
            HudView(hudMessage: hudMessage,
                    backGroundColor: Color.green)
        } else {
            EmptyView()
        }
    }
    
}
