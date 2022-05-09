//
//  DailyWeatherData.swift
//  Weather
//
//  Created by Mitrio on 01.05.2022.
//

import Foundation

struct DailyWeatherData: Codable {
    var daily: [Daily]
}

struct Daily: Codable {
    var dt: Double
    var temp: Temp
    var humidity: Int
    var weather: [DWeather]
}

struct Temp: Codable {
    var min: Double
    var max: Double
}

struct DWeather: Codable {
    var id: Int
}
