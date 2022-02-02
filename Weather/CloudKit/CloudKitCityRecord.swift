//
//  CloudKitCityRecord.swift
//  Weather
//
//  Created by Jan Hovland on 13/03/2021.
//

import CloudKit

import SwiftUI

struct CloudKitCityRecord {
    
    static var database = CKContainer(identifier: Config.containerIdentifier).publicCloudDatabase
    
    /// Inneholder:
    ///     fetchCity
    ///     saveCity
    ///     deleteCity
    
    struct RecordType {
        static let city = "City"
    }
    
    /// MARK: - errors
    enum CloudKitHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    /// MARK: - saving cityRecord to CloudKit
    static func saveCity(_ cityRecord: CityRecord) async throws {
        let cityRec = CKRecord(recordType: RecordType.city)
        cityRec["lat"] = cityRecord.lat as CKRecordValue
        cityRec["lon"] = cityRecord.lon as CKRecordValue
        cityRec["city"] = cityRecord.city as CKRecordValue
        do {
            try await database.save(cityRec)
        } catch {
            throw error
        }
    }
   
    // MARK: - check if the cityRecord exists
    static func existCity(_ cityRecord: CityRecord) async throws -> Bool {
        let predicate = NSPredicate(format: "city = %@", cityRecord.city)
        let query = CKQuery(recordType: RecordType.city, predicate: predicate)
        do {
            let result = try await database.records(matching: query)
            for _ in result.0 {
                return true
            }
        } catch {
            throw error
        }
        return false
     }
    
    /// MARK: - fetching cityRecord from CloudKit
    static func findCitys(_ predicate:  NSPredicate) async throws -> [CityRecord] {
        var cityRecords = [CityRecord]()
        let query = CKQuery(recordType: RecordType.city, predicate: predicate)
        do {
            ///
            /// Slik finnes alle postene
            ///
            let result = try await database.records(matching: query)
            
            for record in result .matchResults {
                var cityRecord = CityRecord()
                ///
                /// Slik hentes de enkelte feltene ut:
                ///
                let cit  = try record.1.get()
                let id = record.0.recordName
                let recID = CKRecord.ID(recordName: id)
                let lat = cit.value(forKey: "lat") ?? 0.00
                let lon = cit.value(forKey: "lon") ?? 0.00
                let city = cit.value(forKey: "city") ?? ""
  
                cityRecord.recordID = recID
                cityRecord.lat = lat as! Double
                cityRecord.lon = lon as! Double
                cityRecord.city = city as! String

                cityRecords.append(cityRecord)
                cityRecords.sort(by: {$0.city < $1.city})
            }
            return cityRecords
        } catch {
            throw error
        }
    }

    // MARK: - delete from CloudKit inside CloudKitArticle
    static func deleteCity(_ recID: CKRecord.ID) async throws {
        do {
            try await database.deleteRecord(withID: recID)
        } catch {
            throw error
        }
    }
    
    // MARK: - modify in CloudKit inside CloudKitArticle
    static func modifyCity(_ cityRecord: CityRecord) async throws {
        
        guard let recID = cityRecord.recordID else { return }
        
        do {
            let city = CKRecord(recordType: RecordType.city)
            city["lat"] = cityRecord.lat
            city["lon"] = cityRecord.lon
            city["city"] = cityRecord.city
            do {
                let _ = try await database.modifyRecords(saving: [city], deleting: [recID])
            } catch {
                throw error
            }
        } catch {
            throw error
        }
    }

    func cityRecordID(_ predicate: NSPredicate) async throws -> CKRecord.ID? {
        let query = CKQuery(recordType: RecordType.city, predicate: predicate)
        do {
            ///
            /// Siden database.records(matching: query) er brukt tidligere må CloudKitArticle settes inn foran database
            ///
            let result = try await CloudKitCityRecord.database.records(matching: query)
            for res in result.0 {
                let id = res.0.recordName
                return CKRecord.ID(recordName: id)
            }
        } catch {
            throw error
        }
        return nil
    }
    
    func deleteCitys(_ predicate: NSPredicate, _ recID: CKRecord.ID) async throws {
        let query = CKQuery(recordType: RecordType.city, predicate: predicate)
        do {
            let result = try await CloudKitCityRecord.database.records(matching: query)
            for res in result.0 {
                let id = res.0.recordName
                let recID = CKRecord.ID(recordName: id)
                try await CloudKitCityRecord.database.deleteRecord(withID: recID)
            }
        } catch {
            throw error
        }
    }

}
