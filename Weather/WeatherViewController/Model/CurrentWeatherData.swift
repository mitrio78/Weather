//
//  CurrentWeather.swift
//  Weather
//
//  Created by Mitrio on 12.04.2022.
//

import Foundation

struct CurrentWeatherData: Codable {
    let coord: Coord
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let description: String
}

