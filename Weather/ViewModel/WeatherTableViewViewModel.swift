//
//  WeatherTableViewViewModel.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation

class WeatherTableViewViewModel: WeatherViewModelProtocol {
    
    var networkManager = NetworkManager()
    private var city: String = "Moscow"
    private var currentWeatherViewModel: CurrentWeatherCellViewModelType?
    
    func fetchData() {
        networkManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
    }
    
    func getCurrentWeatherCellViewModel() -> CurrentWeatherCellViewModelType? {
        print(#function)
        networkManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        networkManager.onCompletion = { [unowned self] currentWeather in
                currentWeatherViewModel = CurrentWeatherCellViewModel(curentWeather: currentWeather)
        }
        guard let currentWeatherViewModel = currentWeatherViewModel else {
            print("No data yet")
            return nil
        }
        print(currentWeatherViewModel.cityName)
        return currentWeatherViewModel
    }
    
    func numberOfRowsInDailyWeatherSection() -> Int {
        return dailyWeatherData.count
    }
    
    //MARK: - TestData
    
    var dailyWeatherData = [
        DailyWeatherModel(date: Date(), dailyMaxTemp: -3, dailyMinTemp: -5, dailyHumidity: 78, weatherCode: 300),
        DailyWeatherModel(date: Date()+80000, dailyMaxTemp: 0, dailyMinTemp: 4, dailyHumidity: 98, weatherCode: 800),
        DailyWeatherModel(date: Date()+160000, dailyMaxTemp: -2, dailyMinTemp: 5, dailyHumidity: 45, weatherCode: 801),
        DailyWeatherModel(date: Date()+240000, dailyMaxTemp: 3, dailyMinTemp: 8, dailyHumidity: 56, weatherCode: 801),
        DailyWeatherModel(date: Date()+320000, dailyMaxTemp: 5, dailyMinTemp: 9, dailyHumidity: 54, weatherCode: 500),
        DailyWeatherModel(date: Date()+400000, dailyMaxTemp: 5, dailyMinTemp: 9, dailyHumidity: 54, weatherCode: 500),
        DailyWeatherModel(date: Date()+480000, dailyMaxTemp: 5, dailyMinTemp: 9, dailyHumidity: 54, weatherCode: 500),
        DailyWeatherModel(date: Date()+560000, dailyMaxTemp: 15, dailyMinTemp: -19, dailyHumidity: 54, weatherCode: 500),
        DailyWeatherModel(date: Date()+640000, dailyMaxTemp: 5, dailyMinTemp: 9, dailyHumidity: 54, weatherCode: 500),
        DailyWeatherModel(date: Date()+740000, dailyMaxTemp: 5, dailyMinTemp: 9, dailyHumidity: 54, weatherCode: 500)
    ]
    
    var hourlyWeatherData = [
        HourlyWeatherModel(hTemp: 7.0, windSpeed: 6.0, hourlyTime: Date(), hourString: "5", weatherCode: 802),
        HourlyWeatherModel(hTemp: 8.0, windSpeed: 5.0, hourlyTime: Date(), hourString: "6", weatherCode: 800),
        HourlyWeatherModel(hTemp: 5.0, windSpeed: 7.0, hourlyTime: Date(), hourString: "7", weatherCode: 300),
        HourlyWeatherModel(hTemp: 7.0, windSpeed: 8.0, hourlyTime: Date(), hourString: "8", weatherCode: 802),
        HourlyWeatherModel(hTemp: 5.0, windSpeed: 9.0, hourlyTime: Date(), hourString: "9", weatherCode: 800),
        HourlyWeatherModel(hTemp: 5.0, windSpeed: 10.0, hourlyTime: Date(), hourString: "10", weatherCode: 300)
    ]
}
