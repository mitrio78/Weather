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
    
    var onCompletion: ((CurrentWeatherModel) -> Void)?
    
    let apiKey = "99036c111dc2331bd211f348a9c37088"
    let lang = "ru"
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=\(lang)"
        case .coordinates(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(with: urlString)
    }
    
    fileprivate func parseJSON(from data: Data) -> CurrentWeatherModel? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeatherModel(currentWeatherData: currentWeatherData) else { return nil}
            print(currentWeather.conditions)
            print(currentWeather.location)
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    fileprivate func performRequest(with urlString: String) {
        print("Begin Network request")
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                print("Data recieved")
                if let currentWeather = self.parseJSON(from: data) {
                    self.onCompletion?(currentWeather)
                    print("Data passed")
                }
            }
        }
        print("Task resumed")
        task.resume()
    }
}
