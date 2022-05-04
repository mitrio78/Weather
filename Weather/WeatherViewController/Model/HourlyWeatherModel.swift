//
//  HourlyWeatherModel.swift
//  Weather
//
//  Created by Mitrio on 18.04.2022.
//

import Foundation

struct HourlyWeatherModel {
    var hTemp: Double
    var htempString: String {
        return String("\(Int(hTemp))ºC")
    }
    var hourlyTime: Date
    var hourString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        return dateFormatter.string(from: hourlyTime)
    }
    var weatherCode: Int
    
    init?(data: Hourly) {
        self.hTemp = data.temp
        self.hourlyTime = data.dt
        self.weatherCode = data.weather[0].id
    }
}


