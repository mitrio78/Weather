//
//  NetworkManager.swift
//  Weather
//
//  Created by Mitrio on 12.04.2022.
//

import Foundation
import CoreLocation

class NetworkManager {
    enum RequestType {
        case cityName(city: String)
        case coordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    //TODO: make singleton
    
    var onCompletion: ((CurrentWeatherModel) -> Void)?
    var onHCompletion: (([HourlyWeatherModel]) -> Void)?
    var onDCompletion: (([DailyWeatherModel]) -> Void)?
    
    let apiKey = "99036c111dc2331bd211f348a9c37088"
    let lang = "ru"
    
    func fetchWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=\(lang)"
            performRequest(with: urlString)
        case .coordinates(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=current,minutely&appid=\(apiKey)&units=metric&lang=\(lang)"
            performHourlyDailyRequest(with: urlString)
        }
    }
    
    fileprivate func parseJSON(from data: Data) -> CurrentWeatherModel? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeatherModel(currentWeatherData: currentWeatherData) else { return nil}
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    fileprivate func parseHourlyJson(from data: Data) -> [HourlyWeatherModel]? {
        let decoder = JSONDecoder()
        do {
            var horlyWeatherModel: [HourlyWeatherModel] = []
            let hourlyWeatherData = try decoder.decode(HourlyWeatherData.self, from: data)
            for weather in hourlyWeatherData.hourly {
                horlyWeatherModel.append(HourlyWeatherModel(time: weather.dt,
                                                            temp: weather.temp,
                                                            weatherID: weather.weather[0].id)!)
            }
            return horlyWeatherModel
        } catch let jsonError {
            print("Failed decode JSON, \(jsonError.localizedDescription)")
            return nil
        }
    }
    
    fileprivate func parseDailyJson(from data: Data) -> [DailyWeatherModel]? {
        let decoder = JSONDecoder()
        do {
            var dailyWeatherModel: [DailyWeatherModel] = []
            let dailyWeatherData = try decoder.decode(DailyWeatherData.self, from: data)
            for weather in dailyWeatherData.daily {
                dailyWeatherModel.append(DailyWeatherModel(date: weather.dt,
                                                                       dailyMaxTemp: weather.temp.max,
                                                                       dailyMinTemp: weather.temp.min,
                                                                       dailyHumidity: weather.humidity,
                                                                       weatherCode: weather.weather[0].id)!)
            }
            return dailyWeatherModel
        } catch let jsonError {
            print("Failed decode JSON, \(jsonError.localizedDescription)")
            return nil
        }
    }
    
    
    fileprivate func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let weather = self.parseJSON(from: data) {
                    self.onCompletion?(weather)
                }
            }
        }
        task.resume()
    }

    fileprivate func performHourlyDailyRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                if let hourlyWeather = self.parseHourlyJson(from: data) {
                    self.onHCompletion?(hourlyWeather)
                }
                if let dailyWeather = self.parseDailyJson(from: data) {
                    self.onDCompletion?(dailyWeather)
                }
            }
        }
        task.resume()
    }
}
