//
//  SearchResponse.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation

struct SearchDataModel {
    
    var cityName: String
    var weatherCode: Int
    var temp: Double
    var tempString: String {
        return String(format: "%.0fº", temp)
    }
    var latitude: Double
    var longitude: Double
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temp = currentWeatherData.main.temp
        weatherCode = currentWeatherData.weather[0].id
        latitude = currentWeatherData.coord.lat
        longitude = currentWeatherData.coord.lon
    }
    
    init?(cityName: String, temp: Double, weatherCode: Int, latitude: Double, longitude: Double) {
        self.cityName = cityName
        self.temp = temp
        self.weatherCode = weatherCode
        self.latitude = latitude
        self.longitude = longitude
    }
}
