//
//  LonLat.swift
//  Weather
//
//  Created by Jan Hovland on 14/08/2022.
//

import Foundation

struct LonLat : Decodable {
    var results = [Result()]
    var query = Query()
}

struct Result  : Decodable {
    var datasource = Datasource()
    var name = String()
    var suburb = String()
    var city = String()
    var county = String()
    var postcode = String()
    var country = String()
    var countryCode = String()
    var hamlet : String?
    var lon = Double()
    var lat = Double()
    var formatted = String()
    var addressLine1 = String()
    var addressline2 = String()
    var category : String?
    var resultType = String()
    var rank = Rank()
    var placeID = String()
    var bbox = Bbox()
    var street : String?
    
    enum CodingKeys: String, CodingKey {
            case datasource, name, suburb, city, county, postcode, country
            case countryCode = "country_code"
            case hamlet, lon, lat, formatted
            case addressLine1 = "address_line1"
            case addressline2 = "address_line2"
            case category
            case resultType = "result_type"
            case rank
            case placeID = "place_id"
            case bbox, street
        }
   
}

struct Datasource : Decodable {
    var sourcename = String()
    var attribution = String()
    var license = String()
    var url = String()
}

struct Rank : Decodable {
    var importance = Double()
    var popularity = Double()
    var confidence = Int()
    var confidenceCityLevel = Int()
    var matchType = String()
    
    enum CodingKeys: String, CodingKey {
            case importance, popularity, confidence
            case confidenceCityLevel = "confidence_city_level"
            case matchType = "match_type"
        }
    
}

struct Bbox: Decodable {
    var lon1 = Double()
    var lat1 = Double()
    var lon2 = Double()
    var lat2 = Double()
}

struct Query: Decodable {
    var text = String()
    var parsed = Parsed()
}

struct Parsed: Decodable {
    var city = String()
    var country = String()
    var expectedType = String()

    enum CodingKeys: String, CodingKey {
        case city, country
        case expectedType = "expected_type"
    }
}

