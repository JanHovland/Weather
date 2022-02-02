//
//  Alert_Record.swift
//  Weather
//
//  Created by Jan Hovland on 22/12/2021.
//

import Foundation

func setAlertRecord(value: WeatherDetail) -> (String, [AlertRecord]) {
    
    var alertRecords = [AlertRecord]()
    var alertButtonText = String()

    let numberOfAlerts = (value.alerts?.count) ?? 0
    let alerts_sender_name = value.alerts?[0].sender_name ?? ""

    for i in 0..<numberOfAlerts {

        var alerts_event = value.alerts?[i].event ?? ""

        if alerts_event == "Snow" {
            alerts_event =  "Snow"
        } else if alerts_event == "Gale" {
            alerts_event =  "Gale"
        } else if alerts_event == "Gale" {
            alerts_event =   "Thunderstorm"
        } else if alerts_event == "Gale" {
            alerts_event =  "Gale"
        } else if alerts_event == "Drizzle" {
            alerts_event =  "Drizzle"
        } else if alerts_event == "Atmosphere" {
            alerts_event =  "Atmosphere"
        } else if alerts_event == "Clear" {
            alerts_event =  "Clear"
        } else if alerts_event == "Clouds" {
            alerts_event =  "Clouds"
        }

        let alerts_start = (value.alerts![i].start) ?? 0
        let alerts_end  = (value.alerts![i].end) ?? 0
        let alerts_description  = (value.alerts![i].description) ?? ""

        let alertRecord = AlertRecord(sender_name:  alerts_sender_name,
                                      event:        alerts_event,
                                      start:        alerts_start,
                                      end:          alerts_end,
                                      description:  alerts_description)

        alertRecords.append(alertRecord)
        if numberOfAlerts == 1 {
            alerts_event = (value.alerts![0].event)!
            if alerts_event == "Snow" {
                alerts_event =  "Snow"
            } else if alerts_event == "Gale" {
                alerts_event =  "Gale"
            } else if alerts_event == "Thunderstorm" {
                alerts_event =  "Thunderstorm"
            } else if alerts_event == "Drizzle" {
                alerts_event =  "Drizzle"
            } else if alerts_event == "Atmosphere" {
                alerts_event =  "Atmosphere"
            } else if alerts_event == "Clear" {
                alerts_event =  "Clear"
            } else if alerts_event == "Clouds" {
                alerts_event =  "Clouds"
            }
            alertButtonText = alerts_event
        } else {
            alerts_event = (value.alerts![0].event)!
            if alerts_event == "Snow" {
                alerts_event =  "Snow"
            } else if alerts_event == "Gale" {
                alerts_event =  "Gale"
            } else if alerts_event == "Thunderstorm" {
                alerts_event =  "Thunderstorm"
            } else if alerts_event == "Drizzle" {
                alerts_event =  "Drizzle"
            } else if alerts_event == "Atmosphere" {
                alerts_event =  "Atmosphere"
            } else if alerts_event == "Clear" {
                alerts_event =  "Clear"
            } else if alerts_event == "Clouds" {
                alerts_event =  "Clouds"
            }
            alertButtonText = alerts_event + " + \(numberOfAlerts - 1)"
        }
    } // for

    return (alertButtonText, alertRecords)
}
