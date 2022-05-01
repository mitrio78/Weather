//
//  HourlyWeatherCellViewModel.swift
//  Weather
//
//  Created by Mitrio on 29.04.2022.
//

import Foundation
import UIKit

class HourlyWeatherCellViewModel {
    var hourlyWeather: [HourlyWeatherModel]
    
    init(hourlyWeather: [HourlyWeatherModel]) {
        self.hourlyWeather = hourlyWeather
    }
}
