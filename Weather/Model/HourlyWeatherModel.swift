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
    

}
