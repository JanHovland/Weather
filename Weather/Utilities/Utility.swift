//
//  Utility.swift
//  Weather
//
//  Created by Jan Hovland on 10/03/2021.
//

import Foundation

/// https://nsdateformatter.com

//  Thursday, Mar 25, 2021              EEEE, MMM d, yyyy
//  03/25/2021                          MM/dd/yyyy
//  03-25-2021 20:52                    MM-dd-yyyy HH:mm
//  Mar 25, 8:52                        PM MMM d, h:mm a
//  March 2021                          MMMM yyyy
//  Mar 25, 2021                        MMM d, yyyy
//  Thu, 25 Mar 2021 20:52:00 +0000     E, d MMM yyyy HH:mm:ss Z
//  2021-03-25T20:52:00+0000            yyyy-MM-dd'T'HH:mm:ssZ
//  25.03.21                            dd.MM.yy
//  20:52:00.455                        HH:mm:ss.SSS

func IntervalToHourMin(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.dateFormat = "HH:mm"
   return formatter.string(from: time as Date)
}

func IntervalToHour(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.dateFormat = "HH"
   return formatter.string(from: time as Date)
}

func IntervalToDayOfWeek(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "E dd MMMM"
   return formatter.string(from: time as Date)
}

func IntervalToDayOfWeekHourMin(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "E dd MMMM HH:mm"
   return formatter.string(from: time as Date)
}

func IntervalToWeekDay(interval: Int) -> String {
    let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "no")
    formatter.dateFormat = "E"
    let str = formatter.string(from: time as Date)
    return str.replacingOccurrences(of: ".", with: "")
}

func IntervalToDayOfMonth(interval: Int) -> String {
    let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "no")
    formatter.dateFormat = "dd"
    return formatter.string(from: time as Date)
 }

func IntervalToDate(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "E dd"
   return formatter.string(from: time as Date)
}

func IntervalToCompleteDayNameOfWeek(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "EEEE d. MMM"
   return formatter.string(from: time as Date)
}

///
/// https://www.w3schools.com/tags/ref_urlencode.ASP
///
 
//
/// Usage:  city = "??lesund, Norge"
/// city = TranslateCity(str: city)      ->     %C3%85lesund,%20Norge
///

func TranslateCity(str: String) -> String {
    let m0  = str.replacingOccurrences(of: " ", with: "%20")
    let m1  =  m0.replacingOccurrences(of: "??", with: "%C3%A6")
    let m2  =  m1.replacingOccurrences(of: "??", with: "%C3%86")
    let m3  =  m2.replacingOccurrences(of: "??", with: "%C3%B8")
    let m4  =  m3.replacingOccurrences(of: "??", with: "%C3%98")
    let m5  =  m4.replacingOccurrences(of: "??", with: "%C3%A5")
    let m6  =  m5.replacingOccurrences(of: "??", with: "%C3%85")
    let m7  =  m6.replacingOccurrences(of: "??", with: "%C3%AB")
    let m8  =  m7.replacingOccurrences(of: "??", with: "%C3%8B")
    let m9  =  m8.replacingOccurrences(of: "??", with: "%C3%B6")
    let m10 =  m9.replacingOccurrences(of: "??", with: "%C3%96")
    let m11 = m10.replacingOccurrences(of: "??", with: "%C3%A1")
    let m12 = m11.replacingOccurrences(of: "??", with: "%C3%81")
    let m13 = m12.replacingOccurrences(of: "??", with: "%C3%BC")
    let m14 = m13.replacingOccurrences(of: "??", with: "%C3%9C")
    let m15 = m14.replacingOccurrences(of: "??", with: "%C3%A9")
    let m16 = m15.replacingOccurrences(of: "??", with: "%C3%89")
    
    return String(m16)
}

struct Wind: Decodable {
    
    let speed: Float
    let deg: Float?
    
    enum Direction: String {
        case north = "N"
        case northEast = "NE"
        case east = "E"
        case southEast = "SE"
        case south = "S"
        case southWest = "SW"
        case west = "W"
        case northWest = "NW"
        
        init(deg: Float) {
            if deg < 23 || deg > 337 {
                self = .north
            } else if deg < 68 {
                self = .northEast
            } else if deg < 113 {
                self = .east
            } else if deg < 158 {
                self = .southEast
            } else if deg < 203 {
                self = .south
            } else if deg < 248 {
                self = .southWest
            } else if deg < 293 {
                self = .west
            } else {
                self = .northWest
            }
        }
    }
    
    var direction: String? {
        guard let deg = deg else { return nil }
        return Direction(deg: deg).rawValue
    }
}

func WindDirection(deg: Int) -> String {
    
    if deg < 23 || deg > 337 {
        return NSLocalizedString("N", comment: "WindDirection")
    } else if deg < 68 {
        return NSLocalizedString("NE", comment: "WindDirection")
    } else if deg < 113 {
        return NSLocalizedString("E", comment: "WindDirection")
    } else if deg < 158 {
        return NSLocalizedString("SE", comment: "WindDirection")
    } else if deg < 203 {
        return NSLocalizedString("S", comment: "WindDirection")
    } else if deg < 248 {
        return NSLocalizedString("SW", comment: "WindDirection")
    } else if deg < 293 {
        return NSLocalizedString("W", comment: "WindDirection")
    } else {
        return NSLocalizedString("NW", comment: "WindDirection")
    }
}
