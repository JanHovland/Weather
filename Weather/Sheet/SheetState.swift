//
//  SheetState.swift
//  Weather
//
//  Created by Jan Hovland on 15/03/2021.
//

import SwiftUI

import Combine

class SheetState<State>: ObservableObject {
    @Published var isShowing = false
    @Published var state: State? {
        didSet { isShowing = state != nil }
    }
}
