//
//  WeatherTableViewViewModel.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation
import CoreLocation

class WeatherTableViewViewModel: WeatherViewModelProtocol {
    
    private var networkServiceForCurrentWeather: NetworkService<CurrentWeatherData> = NetworkService()
    private var networkServiceForDailyWeather: NetworkService<DailyWeatherData> = NetworkService()
    private var networkServiceForHourlyWeather: NetworkService<HourlyWeatherData> = NetworkService()
    
    //TODO: location comes from outside - searchVC
    var lat: Double = 55.7558
    var lon: Double = 37.6176
    
    //View Models
    var currentWeatherCellViewModel: CurrentWeatherCellViewModelProtocol?
    var hourlyWeatherCellViewModel: [HourlyWeatherCellViewModelProtocol]?
    var dailyWeatherCellViewModel: [DailyWeatherCellViewModelProtocol]?
    
    func fetchCurrentWeather(completion: @escaping () -> Void) {
        networkServiceForCurrentWeather.fetchWeather(request: .coordinatesForCurrentWeatherCallApi(latitude: CLLocationDegrees(Float(lat)), longitude: CLLocationDegrees(Float(lon)))) { [unowned self] (currentWeatherData) in
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
        networkServiceForHourlyWeather.fetchWeather(request: .coordinatesForOneCallApi(latitude: CLLocationDegrees(Float(lat)), longitude: CLLocationDegrees(Float(lon))), completion: { [unowned self] (hourlyWeatherData) in
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
        networkServiceForDailyWeather.fetchWeather(request: .coordinatesForOneCallApi(latitude: CLLocationDegrees(Float(lat)), longitude: CLLocationDegrees(Float(lon))), completion: { [unowned self] (dailyWeatherData) in
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
