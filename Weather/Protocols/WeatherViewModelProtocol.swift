//
//  WeatherViewModelProtocol.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation

protocol WeatherViewModelProtocol {
    func numberOfRowsInDailyWeatherSection() -> Int
    func getCurrentWeatherCellViewModel() -> CurrentWeatherCellViewModelType?
    //TempData
    var dailyWeatherData: [DailyWeatherModel] { get }
    var hourlyWeatherData: [HourlyWeatherModel] { get }
    func fetchData() -> Void
}
