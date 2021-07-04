//
//  HudViewe.swift
//  PersonalOverView
//
//  Created by Jan Hovland on 03/05/2021.
//

import SwiftUI

///
/// Bruk:          HudView(textMessage: "textMessage")
///

struct HudView: View {
    var hudMessage: String
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showHUD = false
    var body: some View {
        Hud(hudMessage: hudMessage)
            .cornerRadius(10)
            .onAppear() {
                self.showHUD = true
                dismissHUD()
            }
            // .animation(.spring())
            //.spring())
             
    }
    
    func dismissHUD() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showHUD = false
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}
 
