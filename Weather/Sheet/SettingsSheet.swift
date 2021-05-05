//
//  SettingsSheet.swift
//  Weather
//
//  Created by Jan Hovland on 15/03/2021.
//

import SwiftUI

class SettingsSheet: SheetState<SettingsSheet.State> {
    enum State {
        case alertView
        case cityView
        case hudView
    }
}
