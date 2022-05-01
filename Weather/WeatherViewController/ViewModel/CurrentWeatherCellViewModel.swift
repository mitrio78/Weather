//
//  CurrentWeatherCellViewModel.swift
//  Weather
//
//  Created by Mitrio on 28.04.2022.
//

import Foundation
import CoreLocation

class CurrentWeatherCellViewModel: CurrentWeatherCellViewModelType {
    
    var currentWeather: CurrentWeatherModel
    
    var cityName: String {
        return currentWeather.location
    }
    var currentTemp: String {
        return currentWeather.tempString
    }
    var currentConditions: String {
        return currentWeather.conditions
    }
    var currentMaxMinTempString: String {
        return "Макс.: \(currentWeather.maxTempString) мин.: \(currentWeather.minTempString)"
    }
    var latitude: CLLocationDegrees {
        return currentWeather.latitude
    }
    var longitude: CLLocationDegrees {
        return currentWeather.longitude
    }
    
    init(curentWeather: CurrentWeatherModel) {
        self.currentWeather = curentWeather
    }
}
