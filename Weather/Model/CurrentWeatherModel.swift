//
//  WeatherModel.swift
//  Weather
//
//  Created by Mitrio on 12.04.2022.
//

import Foundation

struct CurrentWeatherModel {
    
    var temp: Double
    var tempString: String {
        return String(format: "%.0fº", temp)
    }
    var minTemp: Double
    var minTempString: String {
        return String(format: "%.0fº", minTemp)
    }
    var maxTemp: Double
    var maxTempString: String {
        return String(format: "%.0fº", maxTemp)
    }
    var conditions: String
    
    var location: String
    
    init?(currentWeatherData: CurrentWeatherData) {
        location = currentWeatherData.name
        temp = currentWeatherData.main.temp
        maxTemp = currentWeatherData.main.temp_max
        minTemp = currentWeatherData.main.temp_min
        conditions = currentWeatherData.weather[0].description
        print("currentWeatherModel INIT")
    }
    
    
}

