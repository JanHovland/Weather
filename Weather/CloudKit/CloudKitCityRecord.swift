//
//  CloudKitCityRecord.swift
//  Weather
//
//  Created by Jan Hovland on 13/03/2021.
//

import CloudKit
import SwiftUI

struct CloudKitCityRecord {
    
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
    
    // MARK: - check if the cityRecord exists
    static func doesCityRecordExist(city: String,
                                    completion: @escaping (Bool) -> ()) {
        var result = false
        let predicate = NSPredicate(format: "city = %@", city)
        let query = CKQuery(recordType: RecordType.city, predicate: predicate)
        /// inZoneWith: nil : Specify nil to search the default zone of the database.
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil, completionHandler: { (results, er) in
            DispatchQueue.main.async {
                result = false
                if results != nil {
                    if results!.count >= 1 {
                        result = true
                    }
                }
                completion(result)
            }
        })
    }
    
    /// MARK: - fetching cityRecord from CloudKit
    static func fetchCityRecord(predicate:  NSPredicate, completion: @escaping (Result<CityRecord, Error>) -> ()) {
        let sort = NSSortDescriptor(key: "city", ascending: false)
        let query = CKQuery(recordType: RecordType.city, predicate: predicate)
        query.sortDescriptors = [sort]
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["lat","lon","city","icon","temp","description","deg","wind_speed", "wind_gust"]
        operation.resultsLimit = 500
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let recordID = record.recordID
                
                /// Dersom en oppretter poster i City tabellen i CloudKit Dashboard og det ikke legges inn verdier,
                /// vil feltene  fra City tabellen være tomme dvs. nil
                if record["lat"] == nil { record["lat"] = 0.0 }
                if record["lon"] == nil { record["lon"] = 0.0 }
                if record["city"] == nil { record["city"] = "" }
                if record["icon"] == nil { record["icon"] = "000" }
                if record["temp"] == nil { record["temp"] = 0.0 }
                if record["description"] == nil { record["description"] = "" }
                if record["deg"] == nil { record["deg"] = 0}
                if record["wind_speed"] == nil { record["wind_speed"] = 0.0 }
                if record["wind_gust"] == nil { record["wind_gust"] = 0.0 }

                guard let lat = record["lat"] as? Double else { return }
                guard let lon = record["lon"] as? Double else { return }
                guard let city = record["city"] as? String else { return }
                guard let icon = record["icon"] as? String else { return }
                guard let temp = record["temp"] as? Double else { return }
                guard let description = record["description"] as? String else { return }
                guard let deg = record["deg"] as? Int else { return }
                guard let wind_speed = record["wind_speed"] as? Double else { return }
                guard let wind_gust = record["wind_gust"] as? Double else { return }

                let cityRecord = CityRecord(recordID: recordID,
                                            lat: lat,
                                            lon: lon,
                                            city: city,
                                            icon: icon,
                                            temp: temp,
                                            description: description,
                                            deg: deg,
                                            wind_speed: wind_speed,
                                            wind_gust: wind_gust)
                                    
                completion(.success(cityRecord))
            }
        }
        operation.queryCompletionBlock = { ( _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
            }
        }
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    /// MARK: - saving cityRecord to CloudKit
    static func saveCityRecord(cityRecord: CityRecord, completion: @escaping (Result<CityRecord, Error>) -> ()) {
        let cityRec = CKRecord(recordType: RecordType.city)
        cityRec["lat"] = cityRecord.lat as CKRecordValue
        cityRec["lon"] = cityRecord.lon as CKRecordValue
        cityRec["city"] = cityRecord.city as CKRecordValue
        cityRec["icon"] = cityRecord.icon as CKRecordValue
        cityRec["temp"] = cityRecord.temp as CKRecordValue
        cityRec["description"] = cityRecord.description as CKRecordValue
        cityRec["deg"] = cityRecord.deg as CKRecordValue
        cityRec["wind_speed"] = cityRecord.wind_speed as CKRecordValue
        cityRec["wind_gust"] = cityRecord.wind_gust! as CKRecordValue
        
        CKContainer.default().privateCloudDatabase.save(cityRec) { (record, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let record = record else {
                    completion(.failure(CloudKitHelperError.recordFailure))
                    return
                }
                let recordID = record.recordID
                
                guard let lat = record["lat"] as? Double else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                
                guard let lon = record["lon"] as? Double else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                
                guard let city = record["city"] as? String else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                
                guard let icon = record["icon"] as? String else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                
                guard let temp = record["temp"] as? Double else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }

                guard let description = record["description"] as? String else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }

                guard let deg = record["deg"] as? Int else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }

                guard let wind_speed = record["wind_speed"] as? Double else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }

                guard let wind_gust = record["wind_gust"] as? Double else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }

                let cityRecord = CityRecord(recordID: recordID,
                                            lat: lat,
                                            lon: lon,
                                            city: city,
                                            icon: icon,
                                            temp: temp,
                                            description: description,
                                            deg: deg,
                                            wind_speed: wind_speed,
                                            wind_gust: wind_gust)
                                         
                completion(.success(cityRecord))
            }
        }
    }
    
    // MARK: - modify cityRecord in CloudKit
    static func modifyCityRecord(cityRecord: CityRecord, completion: @escaping (Result<CityRecord, Error>) -> ()) {
        guard let recordID = cityRecord.recordID else { return }
        CKContainer.default().privateCloudDatabase.fetch(withRecordID: recordID) { record, err in
            if let err = err {
                DispatchQueue.main.async {
                    completion(.failure(err))
                }
                return
            }
            guard let record = record else {
                DispatchQueue.main.async {
                    completion(.failure(CloudKitHelperError.recordFailure))
                }
                return
            }
            record["lat"] = cityRecord.lat as CKRecordValue
            record["lon"] = cityRecord.lon as CKRecordValue
            record["city"] = cityRecord.city as CKRecordValue
            record["icon"] = cityRecord.icon as CKRecordValue
            record["temp"] = cityRecord.temp as CKRecordValue
            record["description"] = cityRecord.description as CKRecordValue
            record["deg"] = cityRecord.deg as CKRecordValue
            record["wind_speed"] = cityRecord.wind_speed as CKRecordValue
            record["wind_gust"] = cityRecord.wind_gust as CKRecordValue?

            CKContainer.default().privateCloudDatabase.save(record) { (record, err) in
                DispatchQueue.main.async {
                    if let err = err {
                        completion(.failure(err))
                        return
                    }
                    guard let record = record else {
                        completion(.failure(CloudKitHelperError.recordFailure))
                        return
                    }
                    
                    let recordID = record.recordID
                    
                    guard let lat = record["lat"] as? Double else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let lon = record["lon"] as? Double else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let city = record["city"] as? String else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let icon = record["icon"] as? String else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let temp = record["temp"] as? Double else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let description = record["description"] as? String else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let deg = record["deg"] as? Int else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let wind_speed = record["wind_speed"] as? Double else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    guard let wind_gust = record["wind_gust"] as? Double else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    let cityRecord = CityRecord(recordID: recordID,
                                                lat: lat,
                                                lon: lon,
                                                city: city,
                                                icon: icon,
                                                temp: temp,
                                                description: description,
                                                deg: deg,
                                                wind_speed: wind_speed,
                                                wind_gust: wind_gust)
                                         
                    completion(.success(cityRecord))
                }
            }
        }
    }
    // MARK: - delete cityRecord from CloudKit
    static func deleteCityRecord(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        CKContainer.default().privateCloudDatabase.delete(withRecordID: recordID) { (recordID, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let recordID = recordID else {
                    completion(.failure(CloudKitHelperError.recordIDFailure))
                    return
                }
                completion(.success(recordID))
            }
        }
    }
    

}
