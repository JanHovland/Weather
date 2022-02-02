//
//  LocalizedString.swift
//  Weather
//
//  Created by Jan Hovland on 27/01/2022.
//

import SwiftUI

struct LocalizedString: View {
    
    ///
    ///Må jukse litt for å få oversatt disse tekstene
    ///
    
    var body: some View {
        Group {
            Text("The city record has been saved in CloudKit")
            Text("The city record has been deleted")
            Text("The city record has been modified in CloudKit")
            Text("All city records have been deleted")
            Text("Error message from the Server")
            Text("Error finding data 5 Days for : ")
            Text("Error finding data for : ")
            Text("No Internet connection for this device.")
            Text("Error message from the Server")
            Text("Error saving city")
        }
        
        Group {
            Text("This city exists in CloudKit ")
            Text("Delete a city")
            Text("Save city")
            
        }
        
    }
}

