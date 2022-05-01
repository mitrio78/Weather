//
//  HourlyWeatherData.swift
//  Weather
//
//  Created by Mitrio on 29.04.2022.
//

import Foundation

struct HourlyWeatherData: Codable {
    var hourly: [Hourly]
}

struct Hourly: Codable {
    var dt: Date
    var temp: Double
    var weather: [HWeather]
}

struct HWeather: Codable {
    var id: Int
}
