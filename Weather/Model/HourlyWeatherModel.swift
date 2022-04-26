//
//  HourlyWeatherModel.swift
//  Weather
//
//  Created by Mitrio on 18.04.2022.
//

import Foundation
import UIKit

struct HourlyWeatherModel {
    
    var hTemp: Double
    var htempString: String {
        return String(hTemp)
    }
    var windSpeed: Double
    var hourlyTime: Date
    var hourString: String
    var weatherCode: Int
    
    var weatherIcon: UIImage {
        switch weatherCode {
        case 200...232:
            return UIImage(systemName: "cloud.bolt.rain.fill")!
        case 300...321, 520...531:
            return UIImage(systemName: "cloud.rain")!
        case 500...504:
            return UIImage(systemName: "cloud.sun.rain.fill")!
        case 511, 600...622:
            return UIImage(systemName: "snowflake")!
        case 701...781:
            return UIImage(systemName: "cloud.fog.fill")!
        case 800:
            return UIImage(systemName: "sun.max.fill")!
        case 801:
            return UIImage(systemName: "cloud.sun.fill")!
        case 802:
            return UIImage(systemName: "cloud.fill")!
        case 803, 804:
            return UIImage(systemName: "smoke.fill")!
        default:
            return UIImage(systemName: "exclamationmark.icloud.fill")!
        }
    }
    
    static var testData: [HourlyWeatherModel] = [
        HourlyWeatherModel(hTemp: 7.0, windSpeed: 6.0, hourlyTime: Date(), hourString: "5", weatherCode: 802),
        HourlyWeatherModel(hTemp: 8.0, windSpeed: 5.0, hourlyTime: Date(), hourString: "6", weatherCode: 800),
        HourlyWeatherModel(hTemp: 5.0, windSpeed: 7.0, hourlyTime: Date(), hourString: "7", weatherCode: 300),
        HourlyWeatherModel(hTemp: 7.0, windSpeed: 8.0, hourlyTime: Date(), hourString: "8", weatherCode: 802),
        HourlyWeatherModel(hTemp: 5.0, windSpeed: 9.0, hourlyTime: Date(), hourString: "9", weatherCode: 800),
        HourlyWeatherModel(hTemp: 5.0, windSpeed: 10.0, hourlyTime: Date(), hourString: "10", weatherCode: 300)
    ]
}
