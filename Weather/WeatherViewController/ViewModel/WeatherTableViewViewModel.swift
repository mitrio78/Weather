//
//  WeatherTableViewViewModel.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation
import CoreLocation

final class WeatherTableViewViewModel: WeatherViewModelProtocol {
    
    var coordinates: LocationCoordinatesProtocol?
    
    private var networkServiceForCurrentWeather: NetworkService<CurrentWeatherData> = NetworkService()
    private var networkServiceForDailyWeather: NetworkService<DailyWeatherData> = NetworkService()
    private var networkServiceForHourlyWeather: NetworkService<HourlyWeatherData> = NetworkService()
    
    //Cell View Models
    var currentWeatherCellViewModel: CurrentWeatherCellViewModelProtocol?
    var hourlyWeatherCellViewModel: [HourlyWeatherCellViewModelProtocol]?
    var dailyWeatherCellViewModel: [DailyWeatherCellViewModelProtocol]?
    
    func fetchCurrentWeather(completion: @escaping () -> Void) {
        guard let coordinates = coordinates else {
            return
        }
        networkServiceForCurrentWeather.fetchWeather(request: .coordinatesForCurrentWeatherCallApi(latitude: coordinates.latitude, longitude: coordinates.longitude)) { [unowned self] (currentWeatherData) in
            guard let currentWeatherData = currentWeatherData else {
                return
            }
            let cModel = CurrentWeatherModel(currentWeatherData: currentWeatherData)
            self.currentWeatherCellViewModel = CurrentWeatherCellViewModel(curentWeather: cModel!)
            self.fetchHourlyWeather {
                completion()
            }
            self.fetchDailyWeather {
                completion()
            }
        }
    }
    func fetchHourlyWeather(completion: @escaping () -> Void) {
        guard let coordinates = coordinates else {
            return
        }
        networkServiceForHourlyWeather.fetchWeather(request: .coordinatesForOneCallApi(latitude: coordinates.latitude, longitude: coordinates.longitude), completion: { [unowned self] (hourlyWeatherData) in
            self.hourlyWeatherCellViewModel = []
            var model: [HourlyWeatherModel] = []
            guard let hModel = hourlyWeatherData?.hourly else { return }
            for hModelItem in hModel {
                model.append(HourlyWeatherModel(data: hModelItem)!)
            }
            for weatherItem in model {
                self.hourlyWeatherCellViewModel?.append(HourlyWeatherCellViewModel(hourlyModel: weatherItem))
            }
            completion()
        })
    }
    func fetchDailyWeather(completion: @escaping () -> Void) {
        guard let coordinates = coordinates else {
            return
        }
        networkServiceForDailyWeather.fetchWeather(request: .coordinatesForOneCallApi(latitude: coordinates.latitude, longitude: coordinates.longitude), completion: { [unowned self] (dailyWeatherData) in
            self.dailyWeatherCellViewModel = []
            var model: [DailyWeatherModel] = []
            guard let dModel = dailyWeatherData?.daily else { return }
            for dModelItem in dModel {
                model.append(DailyWeatherModel(data: dModelItem)!)
            }
            for weatherItem in model {
                self.dailyWeatherCellViewModel?.append(DailyWeatherCellViewModel(model: weatherItem))
            }
            completion()
        })
    }
}
