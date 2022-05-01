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
        return String("\(Int(hTemp))ºC")
    }
    var hourlyTime: Date
    var hourString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        return dateFormatter.string(from: hourlyTime)
    }
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
    
    init?(time: Date, temp: Double, weatherID: Int) {
        hTemp = temp
        hourlyTime = time
        weatherCode = weatherID
    }
}
