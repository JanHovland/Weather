//
//  Current_Record.swift
//  Weather
//
//  Created by Jan Hovland on 20/12/2021.
//

import Foundation

func setCurrentRecord(value: WeatherDetail) -> CurrentRecord {
    
    var currentRecord: CurrentRecord
    
    currentRecord = CurrentRecord(dt:                  (value.current.dt),
                                  sunrise:             (value.current.sunrise),
                                  sunset:              (value.current.sunset),
                                  temp:                (value.current.temp),
                                  feels_like:          (value.current.feels_like),
                                  pressure:            (value.current.pressure),
                                  humidity:            (value.current.humidity),
                                  dew_point:           (value.current.dew_point),
                                  uvi:                 (value.current.uvi),
                                  clouds:              (value.current.clouds),
                                  visibility:          (value.current.visibility),
                                  wind_speed:          (value.current.wind_speed),
                                  wind_deg:            (value.current.wind_deg),
                                  wind_gust:           (value.current.wind_gust) ?? 0.00,
                                  rain_the1h:          (value.current.rain?.the1H) ?? 0.00,
                                  snow_the1h:          (value.current.snow?.the1H) ?? 0.00,
                                  weather_id:          (value.current.weather[0].id),
                                  weather_main:        (value.current.weather[0].main),
                                  weather_description: (value.current.weather[0].description),
                                  weather_icon:        (value.current.weather[0].icon))
    return currentRecord
}
