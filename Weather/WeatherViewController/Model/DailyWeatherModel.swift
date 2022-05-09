//
//  DailyWeatherModel.swift
//  Weather
//
//  Created by Mitrio on 25.04.2022.
//

import UIKit

struct DailyWeatherModel {
    var date: Double
    var dateStrind: String {
        let newDate = NSDate(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateFormat = "d, EE"
        return dateFormatter.string(from: newDate as Date)
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

    init?(data: Daily) {
        self.date = data.dt
        self.dailyMinTemp = data.temp.min
        self.dailyMaxTemp = data.temp.max
        self.weatherCode = data.weather[0].id
        self.dailyHumidity = data.humidity
    }
}
