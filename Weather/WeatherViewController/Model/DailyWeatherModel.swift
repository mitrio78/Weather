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

    init?(data: Daily) {
        self.date = data.dt
        self.dailyMinTemp = data.temp.min
        self.dailyMaxTemp = data.temp.max
        self.weatherCode = data.weather[0].id
        self.dailyHumidity = data.humidity
    }
}
