//
//  PersistenceController.swift
//  Weather
//
//  Created by Jan Hovland on 13/03/2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer
    init(inMemory: Bool = false) {
        /// The name of the container must be the same as the Bundle Identifier ("Weather")
        container = NSPersistentCloudKitContainer(name: "Weather")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                let _ = error.localizedDescription
            }
        })
    }
}

