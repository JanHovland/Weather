//
//  GetApiKey.swift
//  Weather
//
//  Created by Jan Hovland on 30/01/2022.
//

///
///Jeton Fejza :
///
///Leveraging iOS settings bundles for awesomeness
///
///https://blog.undabot.com/leveraging-ios-settings-bundles-for-awesomeness-e93fe0b8e8c1
///

import Foundation
import SwiftUI


func getApiKey() -> String {
    @ObservedObject var setting = Setting()
    let apiKey : String = setting.apiKey
    return apiKey
}
