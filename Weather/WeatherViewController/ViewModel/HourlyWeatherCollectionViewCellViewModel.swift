//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  Weather
//
//  Created by Mitrio on 01.05.2022.
//

import UIKit

class HourlyWeatherCollectionViewCellViewModel {
    
    var hourlyWeather: HourlyWeatherModel
    
    var hTempString: String {
        return hourlyWeather.htempString
    }
    
    var hourString: String {
        return hourlyWeather.hourString
    }
    
    var hourWeatherIcon: UIImage {
        return hourlyWeather.weatherIcon
    }
    
    init(hourlyModel: HourlyWeatherModel) {
        self.hourlyWeather = hourlyModel
    }
}
