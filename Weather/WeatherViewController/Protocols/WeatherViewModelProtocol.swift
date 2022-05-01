//
//  WeatherViewModelProtocol.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation

protocol WeatherViewModelProtocol {
    func fetchCurrentWeather(completion: @escaping() -> Void)
    func fetchHourlyAndDailyWeather(completion: @escaping() -> Void)
    //Data
    var currentWeatherCellViewModel: CurrentWeatherCellViewModelType? { get }
    var dailyWeatherData: [DailyWeatherModel]? { get }
    var hourlyWeatherData: [HourlyWeatherModel]? { get }
}
