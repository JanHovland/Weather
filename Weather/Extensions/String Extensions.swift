//
//  String Extensions.swift
//  Weather
//
//  Created by Jan Hovland on 12/03/2021.
//

import Foundation

///
///  Sette første bokstav til uppercase
///
///   Bruk:  let test = "the rain in Spain"
///

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
