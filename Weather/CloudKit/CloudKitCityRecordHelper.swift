//
//  CloudKitCityRecordHelper.swift
//  Weather
//
//  Created by Jan Hovland on 12/12/2021.
//


import SwiftUI
import CloudKit

func saveCity(_ cityRecord: CityRecord) async -> LocalizedStringKey {
    var message : LocalizedStringKey = ""
    do {
        try await CloudKitCityRecord.saveCity(cityRecord)
        message = LocalizedStringKey("The city record has been saved in CloudKit")
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}

func existCity(_ cityRecord: CityRecord) async -> (err: LocalizedStringKey, exist: Bool) {
    var err : LocalizedStringKey = ""
    var exist : Bool = false
    do {
        exist = try await CloudKitCityRecord.existCity(cityRecord)
        err = ""
    } catch {
        print(error.localizedDescription)
        err  = LocalizedStringKey(error.localizedDescription)
        exist = false
    }
    return (err, exist)
}

func findCitys(_ predicate: NSPredicate) async -> (err: LocalizedStringKey, cityRecords: [CityRecord]) {
    var err : LocalizedStringKey = ""
    var cityRecords = [CityRecord]()
    do {
        err = ""
        cityRecords = try await CloudKitCityRecord.findCitys(predicate)
    } catch {
        err  = LocalizedStringKey(error.localizedDescription)
        cityRecords = [CityRecord]()
    }
    
    return (err , cityRecords)
}

func deleteCity(_ recID: CKRecord.ID) async -> LocalizedStringKey {
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitCityRecord.deleteCity(recID)
        message = "The city record has been deleted"
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}


func modifyCity(_ cityRecord: CityRecord) async -> LocalizedStringKey {
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitCityRecord.modifyCity(cityRecord)
        message = "The city record has been modified in CloudKit"
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}


func cityRecordId(_ predicate: NSPredicate) async -> (err: LocalizedStringKey, id: CKRecord.ID?) {
    var err : LocalizedStringKey = ""
    var id: CKRecord.ID?
    do {
        id = try await CloudKitCityRecord().cityRecordID(predicate)
        err = ""
    } catch {
        print(error.localizedDescription)
        err = LocalizedStringKey(error.localizedDescription)
        id = nil
    }
    return (err, id)
}

func deleteCitys(_ predicate: NSPredicate,_ recID: CKRecord.ID) async -> LocalizedStringKey {
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitCityRecord().deleteCitys(predicate, recID)
        message = "All city records have been deleted"
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}


