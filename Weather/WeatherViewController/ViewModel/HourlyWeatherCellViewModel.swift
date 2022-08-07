//
//  HourlyWeatherCellViewModel.swift
//  Weather
//
//  Created by Mitrio on 29.04.2022.
//

import Foundation

final class HourlyWeatherCellViewModel: HourlyWeatherCellViewModelProtocol {

    var hourlyWeather: HourlyWeatherModel
    
    var hTempString: String {
        return hourlyWeather.htempString
    }
    
    var hourString: String {
        return hourlyWeather.hourString
    }
    
    var weatherId: Int {
        return hourlyWeather.weatherCode
    }
    
    init(hourlyModel: HourlyWeatherModel) {
        self.hourlyWeather = hourlyModel
    }
    
}
