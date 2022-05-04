//
//  SearchTableViewViewModel.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation
import CoreLocation

class SearchTableViewViewModel: SearchTableViewViewModelProtocol {
    
    var savedCities: [SearchDataModel]?
    var currentLocation: LocationCoordinatesProtocol?
    var searchResult: SearchDataModel?
    var networkService = NetworkService<CurrentWeatherData>()

    var latitude: Double?
    var longitude: Double?
    
    func fetchSearchData(searchText: String, completion: @escaping () -> ()) {
        self.networkService.fetchWeather(request: .cityName(city: searchText)) { [weak self] (result) in
            guard let result = result else {
                completion()
                return
            }
            self?.searchResult = SearchDataModel(currentWeatherData: result)
            completion()
        }
    }
    
    func fetchLocationData(location: LocationCoordinates, completion: @escaping (SearchDataModel) -> ()) {
        guard let currentLocation = currentLocation else {
            return
        }
        self.networkService.fetchWeather(request: .coordinatesForCurrentWeatherCallApi(latitude: currentLocation.latitude, longitude: currentLocation.longitude)) { (data) in
            guard let result = SearchDataModel(currentWeatherData: data!) else {
                return
            }
            completion(result)
        }
    }
    
    func fetchSavedCities() {
        savedCities = [
            SearchDataModel(cityName: "City", temp: 4, weatherCode: 2, latitude: 53.033, longitude: -10.223)!
        ]
    }
    
}
