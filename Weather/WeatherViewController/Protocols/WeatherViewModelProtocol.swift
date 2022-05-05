//
//  WeatherViewModelProtocol.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation

protocol WeatherViewModelProtocol {
    
    var coordinates: LocationCoordinatesProtocol? { get set }
    
    func fetchCurrentWeather(completion: @escaping() -> Void)
    func fetchHourlyWeather(completion: @escaping() -> Void)
    func fetchDailyWeather(completion: @escaping() -> Void)
    //Data
    var currentWeatherCellViewModel: CurrentWeatherCellViewModelProtocol? { get }
    var dailyWeatherCellViewModel: [DailyWeatherCellViewModelProtocol]? { get }
    var hourlyWeatherCellViewModel: [HourlyWeatherCellViewModelProtocol]? { get }
}
