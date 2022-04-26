//
//  WeatherDetailsDataSource.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit

class WeatherDetailViewModel: NSObject {
    
    enum WeatherSection: Int, CaseIterable {
        case currentWeather
        case hourlyForecast
        case dailyForecast
        
        var numberOfRows: Int {
            switch self {
            case .currentWeather, .hourlyForecast:
                return 1
            case .dailyForecast:
                return 5
            }
        }

        var displayText: String {
            switch self {
            case .currentWeather:
                return "Текущая погода"
            case .hourlyForecast:
                return "Почасовой прогноз"
            case .dailyForecast:
                return "Прогноз на 5 дней"
            }
        }
        
        func cellClass(for row: Int) -> UITableViewCell {
            switch self {
            case .currentWeather:
                return CurrentWeatherCell()
            case .hourlyForecast:
                return HourlyForecastCell()
            case .dailyForecast:
                return DailyForecastCell()
            }
        }
        
        func cellIdentifier(for row: Int) -> String {
            switch self {
            case .currentWeather:
                return "CurrentWeatherCell"
            case .hourlyForecast:
                return "HourlyForecastCell"
            case .dailyForecast:
                return "DailyForecastCell"
            }
        }
    }
}

