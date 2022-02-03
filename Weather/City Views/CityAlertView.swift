//
//  CityAlertView.swift
//  Weather
//
//  Created by Jan Hovland on 08/04/2021.
//

import SwiftUI

struct cityAlertView: View {

    @Environment(\.presentationMode) var presentationMode
    
    var alertRecords: [AlertRecord]
    
    var body: some View {
        NavigationView {
            VStack {
                Text(alertRecords[0].sender_name!)
                    .font(Font.title.weight(.light))
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                ForEach(alertRecords) { alertRecord in
                    Text(alertRecord.event!)
                        .font(Font.title.weight(.light))
                    Text(alertRecord.description!)
                        .padding(.top, 10)
                    Divider()
                }
                Spacer()
            }
            .navigationBarTitle(Text("Alert View"), displayMode: .large)
            .navigationBarItems(leading:
                                    Button(action: {
                                        /// Rutine for å returnere til personoversikten
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        ReturnFromMenuView(text: NSLocalizedString("Weather", comment: ""))
                                    }))
            .padding()
        }
    }
}

struct ReturnFromMenuView: View {
    var text: String
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 11, height: 18, alignment: .center)
            Text(text)
        }
        .foregroundColor(.none)
        .font(Font.headline.weight(.regular))
    }
}
