//
//  AlertRecord.swift
//  Weather
//
//  Created by Jan Hovland on 08/04/2021.
//

import Foundation

struct AlertRecord: Identifiable {
    var id = UUID()
    var sender_name: String?
    var event: String?
    var start: Int?
    var end: Int?
    var description: String?
}
