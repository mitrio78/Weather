//
//  NetworkService.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation
import Alamofire
import CoreLocation

protocol NetworkServiceProtocol: AnyObject {
    associatedtype T: Codable
    associatedtype RequestType
    func fetchWeather(request: RequestType, completion: @escaping (T?) -> Void)
}

final class NetworkService<T:Codable>: NetworkServiceProtocol {
    enum RequestType {
        case cityName(city: String)
        case coordinatesForCurrentWeatherCallApi(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
        case coordinatesForOneCallApi(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    private let apiKey = NetworkSettings.apiKey
    private let lang = NetworkSettings.lang
    private let body = NetworkSettings.body
    private let currentWeatherCall = NetworkSettings.currentWeatherApi
    private let oneCall = NetworkSettings.oneCallApi
    
    private func getUrl(for request: RequestType) -> String {
        switch request {
        case .cityName(let city):
            let url = body + currentWeatherCall + "q=\(city)&appid=\(apiKey)&units=metric&lang=\(lang)"
            return url
        case .coordinatesForCurrentWeatherCallApi(let latitude, let longitude):
            return body + currentWeatherCall + "lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric&lang=\(lang)"
        case .coordinatesForOneCallApi(latitude: let latitude, longitude: let longitude):
            return body + oneCall + "lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,alerts&appid=\(apiKey)&units=metric&lang=\(lang)"
        }
    }
    
    func getWeatherAsyncroniously(for request: RequestType) async throws -> T {
        guard let url = URL(string: getUrl(for: request)) else {
            throw APIError.wrongUrl
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponseStatus
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.JSONDecoderError(descriprion: error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(descriprion: error.localizedDescription)
        }
    }
    
    func fetchWeather(request: RequestType, completion: @escaping (T?) -> Void) {
        let url = getUrl(for: request)
        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error recieved from response \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()
            do {
                let cityObject = try decoder.decode(T.self, from: data)
                completion(cityObject)
            } catch let jsonError {
                print("failed to decode JSON: \(jsonError.localizedDescription)")
                completion(nil)
            }
        }
    }
}

