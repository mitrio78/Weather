//
//  WeatherTableViewViewModel.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation
import CoreLocation

class WeatherTableViewViewModel: WeatherViewModelProtocol {
    
    var currentWeatherCellViewModel: CurrentWeatherCellViewModelType?
    var networkManager = NetworkManager()
    
    //TODO: city comes from outside - searchVC
    private var city: String = "Leningrad"
    
    var hourlyWeatherCellViewModel: HourlyWeatherCellViewModelType?
    var hourlyWeatherData: [HourlyWeatherModel]?
    var dailyWeatherData: [DailyWeatherModel]?
    
    func fetchCurrentWeather(completion: @escaping() -> Void) {
        networkManager.fetchWeather(forRequestType: .cityName(city: city))
        networkManager.onCompletion = { [weak self] (currentWeather) in
            self?.currentWeatherCellViewModel = CurrentWeatherCellViewModel(curentWeather: currentWeather)
            self?.fetchHourlyAndDailyWeather {
                completion()
            }
        }
    }
    
    func fetchHourlyAndDailyWeather(completion: @escaping() -> Void) {
        guard let currentWeatherCellViewModel = currentWeatherCellViewModel else {
            print("no lat & lon")
            return
        }
        networkManager.fetchWeather(forRequestType: .coordinates(latitude: currentWeatherCellViewModel.latitude, longitude: currentWeatherCellViewModel.longitude))
        networkManager.onHCompletion = { [weak self] (hourlyWeather) in
            self?.hourlyWeatherData = hourlyWeather
            
        }
        networkManager.onDCompletion = { [weak self] (dailyweather) in
            self?.dailyWeatherData = dailyweather
            completion()
        }
        completion()
    }
}
