//
//  Daily_Records.swift
//  Weather
//
//  Created by Jan Hovland on 20/12/2021.
//

import Foundation

func setDailyRecords(value: WeatherDetail) -> [DailyRecord] {
    
    var dailyRecords = [DailyRecord]()
    
    for i in 0...7 {
        let dailyRec = DailyRecord(index:               i,
                                   dt:                  (value.daily[i].dt),
                                   sunrise:             (value.daily[i].sunrise),
                                   sunset:              (value.daily[i].sunset),
                                   moonrise:            (value.daily[i].moonrise),
                                   moonset:             (value.daily[i].moonset),
                                   moon_phase:          (value.daily[i].moon_phase),
                                   temp_day:            (value.daily[i].temp.day),
                                   temp_min:            (value.daily[i].temp.min),
                                   temp_max:            (value.daily[i].temp.max),
                                   temp_night:          (value.daily[i].temp.night),
                                   temp_eve:            (value.daily[i].temp.eve),
                                   temp_morn:           (value.daily[i].temp.morn),
                                   feels_like_day:      (value.daily[i].feels_like.day),
                                   feels_like_night:    (value.daily[i].feels_like.night),
                                   feels_like_eve:      (value.daily[i].feels_like.eve),
                                   feels_like_morn:     (value.daily[i].feels_like.morn),
                                   pressure:            (value.daily[i].pressure),
                                   humidity:            (value.daily[i].humidity),
                                   dew_point:           (value.daily[i].dew_point),
                                   wind_speed:          (value.daily[i].wind_speed),
                                   wind_gust:           (value.daily[i].wind_gust) ?? 0.00,
                                   wind_deg:            (value.daily[i].wind_deg),
                                   weather_id:          (value.daily[i].weather[0].id),
                                   weather_main:        (value.daily[i].weather[0].main),
                                   weather_description: (value.daily[i].weather[0].description),
                                   weather_icon:        (value.daily[i].weather[0].icon),
                                   clouds:              (value.daily[i].clouds),
                                   pop:                 (value.daily[i].pop),
                                   rain_the1h:          (value.daily[i].rain) ?? 0.00,
                                   snow_the1h:          (value.daily[i].snow) ?? 0.00,
                                   uvi:                 (value.daily[i].uvi))

        dailyRecords.append(dailyRec)
    }
    
    return dailyRecords
}
 
