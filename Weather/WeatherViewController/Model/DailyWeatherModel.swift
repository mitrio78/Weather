//
//  DailyWeatherModel.swift
//  Weather
//
//  Created by Mitrio on 25.04.2022.
//

import UIKit

struct DailyWeatherModel {
    var date: Date
    var dateStrind: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: date)
    }
    var dailyMaxTemp: Double
    var dMaxTempString: String {
        return String(format: "макс.: %.0fº", dailyMaxTemp)
    }
    var dailyMinTemp: Double
    var dMinTempString: String {
        return String(format: "мин.: %.0fº", dailyMinTemp)
    }
    var dailyHumidity: Int
    var dHumidityString: String {
        return "\(String(dailyHumidity))%"
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

    init?(date: Date, dailyMaxTemp: Double, dailyMinTemp: Double, dailyHumidity: Int, weatherCode: Int) {
        self.date = date
        self.dailyMinTemp = dailyMinTemp
        self.dailyMaxTemp = dailyMaxTemp
        self.weatherCode = weatherCode
        self.dailyHumidity = dailyHumidity
    }
}
