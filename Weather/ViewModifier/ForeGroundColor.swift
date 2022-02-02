//
//  ForeGroundColor.swift
//  Weather
//
//  Created by Jan Hovland on 18/03/2021.
//

import SwiftUI

struct ForeGroundColor: ViewModifier {
    var temp: Double

    @ViewBuilder
    func body(content: Content) -> some View {
        if self.temp > 0.0 {
            content.foregroundColor(Color(.systemRed))
        } else {
            content.foregroundColor(Color(.systemBlue))
        }
    }
}
