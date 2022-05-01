//
//  WeatherDetailsDataSource.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit

struct WeatherTableViewState {
    
    enum WeatherSection: Int, CaseIterable {
                
        case currentWeather
        case hourlyForecast
        case dailyForecast

        var displayText: String {
            switch self {
            case .currentWeather:
                return "Текущая погода"
            case .hourlyForecast:
                return "Почасовой прогноз"
            case .dailyForecast:
                return ""
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
                return String(describing: CurrentWeatherCell.self)
            case .hourlyForecast:
                return "HourlyForecastCell"
            case .dailyForecast:
                return String(describing: DailyForecastCell.self)
            }
        }
    }
}

