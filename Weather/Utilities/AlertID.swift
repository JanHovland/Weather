//
//  AlertID.swift
//  Weather
//
//  Created by Jan Hovland on 11/03/2021.
//

import SwiftUI

struct AlertID: Identifiable {
    enum Choice {
        case first, second, third, delete, save
    }

    var id: Choice
}
