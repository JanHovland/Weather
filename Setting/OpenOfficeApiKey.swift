//
//  OpenOfficeApiKey.swift
//  Weather
//
//  Created by Jan Hovland on 01/02/2022.
//

import SwiftUI
import Combine

struct OpenOfficeApiKey: View {
    @ObservedObject var setting = Setting()
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("API KEY OPENWEATHERMAP"),
                            footer: Text("Enter a valid Api key to access the OpenWeatherMap")) {
                        TextField("Apikey", text: $setting.apiKey)
                    }
                }
                Spacer()
                Text("Press <Return> for the Home Screen")
                    .padding(.bottom, 10)
            }
            .navigationBarTitle(Text("Setting"), displayMode: .inline)
            .navigationBarItems(leading:
                                    HStack {
                                        Button(action: {
                                            ///
                                            /// exit(1) av slutter appen
                                            ///
                                            exit(1)
                                        }, label: {
                                            ReturnFromMenuView(text: "Return")
                                        })
                                    }
            )
        }
    }
}
