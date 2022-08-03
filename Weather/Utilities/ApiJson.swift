//
//  ApiJson.swift
//  Weather
//
//  Created by Jan Hovland on 03/08/2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let results: [Result]
    let query: Query
}

// MARK: - Query
struct Query: Codable {
    let text: String
    let parsed: Parsed
}

// MARK: - Parsed
struct Parsed: Codable {
    let city, country, expectedType: String

    enum CodingKeys: String, CodingKey {
        case city, country
        case expectedType = "expected_type"
    }
}

// MARK: - Result
struct Result: Codable {
    let datasource: Datasource
    let name, suburb, city, county: String
    let postcode, country, countryCode: String
    let hamlet: String?
    let lon, lat: Double
    let formatted, addressLine1, addressLine2: String
    let category: String?
    let resultType: String
    let rank: Rank
    let placeID: String
    let bbox: Bbox
    let street: String?

    enum CodingKeys: String, CodingKey {
        case datasource, name, suburb, city, county, postcode, country
        case countryCode = "country_code"
        case hamlet, lon, lat, formatted
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case category
        case resultType = "result_type"
        case rank
        case placeID = "place_id"
        case bbox, street
    }
}

// MARK: - Bbox
struct Bbox: Codable {
    let lon1, lat1, lon2, lat2: Double
}

// MARK: - Datasource
struct Datasource: Codable {
    let sourcename, attribution, license: String
    let url: String
}

// MARK: - Rank
struct Rank: Codable {
    let importance, popularity: Double
    let confidence, confidenceCityLevel: Int
    let matchType: String

    enum CodingKeys: String, CodingKey {
        case importance, popularity, confidence
        case confidenceCityLevel = "confidence_city_level"
        case matchType = "match_type"
    }
}

/*

{
  "results": [
    {
      "datasource": {
        "sourcename": "openstreetmap",
        "attribution": "© OpenStreetMap contributors",
        "license": "Open Database License",
        "url": "https://www.openstreetmap.org/copyright"
      },
      "name": "Padlane",
      "suburb": "Padlane",
      "city": "Tysvær",
      "county": "Rogaland",
      "postcode": "5570",
      "country": "Norway",
      "country_code": "no",
      "hamlet": "Padlane",
      "lon": 5.4735778,
      "lat": 59.3808083,
      "formatted": "Padlane, 5570 Tysvær, Norway",
      "address_line1": "Padlane",
      "address_line2": "5570 Tysvær, Norway",
      "category": "populated_place",
      "result_type": "postcode",
      "rank": {
        "importance": 0.46,
        "popularity": 1.39964015447656,
        "confidence": 1,
        "confidence_city_level": 1,
        "match_type": "full_match"
      },
      "place_id": "514f722c94f1e4154059ce458d53beb04d40f00103f90155ab83a701000000c002079203075061646c616e65",
      "bbox": {
        "lon1": 5.4535778,
        "lat1": 59.3608083,
        "lon2": 5.4935778,
        "lat2": 59.4008083
      }
    },
    {
      "datasource": {
        "sourcename": "openstreetmap",
        "attribution": "© OpenStreetMap contributors",
        "license": "Open Database License",
        "url": "https://www.openstreetmap.org/copyright"
      },
      "name": "Padlane",
      "street": "Padlane",
      "suburb": "Padlane",
      "city": "Tysvær",
      "county": "Rogaland",
      "postcode": "5570",
      "country": "Norway",
      "country_code": "no",
      "lon": 5.4737207,
      "lat": 59.3807083,
      "formatted": "Padlane, 5570 Tysvær, Norway",
      "address_line1": "Padlane",
      "address_line2": "5570 Tysvær, Norway",
      "result_type": "street",
      "rank": {
        "importance": 0.31,
        "popularity": 1.39964015447656,
        "confidence": 1,
        "confidence_city_level": 1,
        "match_type": "inner_part"
      },
      "place_id": "51bfc0070a17e51540596be8b00cbbb04d40f00102f90198e6f51000000000c002049203075061646c616e65",
      "bbox": {
        "lon1": 5.4733592,
        "lat1": 59.3786423,
        "lon2": 5.4762848,
        "lat2": 59.3816897
      }
    },
    {
      "datasource": {
        "sourcename": "openstreetmap",
        "attribution": "© OpenStreetMap contributors",
        "license": "Open Database License",
        "url": "https://www.openstreetmap.org/copyright"
      },
      "name": "Padlane",
      "street": "Padlane",
      "suburb": "Padlane",
      "city": "Tysvær",
      "county": "Rogaland",
      "postcode": "5570",
      "country": "Norway",
      "country_code": "no",
      "lon": 5.475051,
      "lat": 59.3815739,
      "formatted": "Padlane, 5570 Tysvær, Norway",
      "address_line1": "Padlane",
      "address_line2": "5570 Tysvær, Norway",
      "result_type": "street",
      "rank": {
        "importance": 0.285,
        "popularity": 1.39964015447656,
        "confidence": 1,
        "confidence_city_level": 1,
        "match_type": "inner_part"
      },
      "place_id": "5177baf3c473e6154059ebc0de69d7b04d40f00102f901106f861600000000c002049203075061646c616e65",
      "bbox": {
        "lon1": 5.4750486,
        "lat1": 59.3815558,
        "lon2": 5.475051,
        "lat2": 59.382033
      }
    },
    {
      "datasource": {
        "sourcename": "openstreetmap",
        "attribution": "© OpenStreetMap contributors",
        "license": "Open Database License",
        "url": "https://www.openstreetmap.org/copyright"
      },
      "name": "Padlane",
      "street": "Førlandsvegen",
      "suburb": "Padlane",
      "city": "Tysvær",
      "county": "Rogaland",
      "postcode": "5570",
      "country": "Norway",
      "country_code": "no",
      "lon": 5.476225,
      "lat": 59.381046,
      "formatted": "Padlane, Førlandsvegen, 5570 Tysvær, Norway",
      "address_line1": "Padlane",
      "address_line2": "Førlandsvegen, 5570 Tysvær, Norway",
      "category": "public_transport.bus",
      "result_type": "amenity",
      "rank": {
        "importance": 0.21100000000000002,
        "popularity": 1.39964015447656,
        "confidence": 1,
        "confidence_city_level": 1,
        "match_type": "inner_part"
      },
      "place_id": "518126c286a7e7154059c422861dc6b04d40f00103f901b18a058100000000c002019203075061646c616e65",
      "bbox": {
        "lon1": 5.476175,
        "lat1": 59.380996,
        "lon2": 5.476275,
        "lat2": 59.381096
      }
    }
  ],
  "query": {
    "text": "Padlane,NO",
    "parsed": {
      "city": "padlane",
      "country": "no",
      "expected_type": "city"
    }
  }
}
 
*/
