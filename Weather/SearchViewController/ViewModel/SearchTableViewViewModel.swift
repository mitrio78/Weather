//
//  SearchTableViewViewModel.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation
import CoreLocation

final class SearchTableViewViewModel: SearchTableViewViewModelProtocol {
    
    var savedCoordinates: [Coordinates]?
    var savedCities: [SearchDataModel]?
    var currentLocation: LocationCoordinatesProtocol?
    var searchResult: SearchDataModel?
    var currentLocationResult: SearchDataModel?
    var networkService = NetworkService<CurrentWeatherData>()
    
    func fetchSearchData(searchText: String, completion: @escaping () -> ()) {
        self.networkService.fetchWeather(request: .cityName(city: searchText)) { [weak self] (result) in
            guard let result = result else {
                self?.searchResult = nil
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
        self.networkService.fetchWeather(request: .coordinatesForCurrentWeatherCallApi(latitude: currentLocation.latitude, longitude: currentLocation.longitude)) { [weak self] (data) in
            guard let data = data else {
                return
            }
            self?.currentLocationResult = SearchDataModel(currentWeatherData: data)
            guard let result = self?.currentLocationResult else {
                return
            }
            completion(result)
        }
    }
    
    func fetchSavedCities() async {
        savedCoordinates = StorageProvider.shared.getAllCoordinates()
        savedCities = []
        guard let savedCoordinates = savedCoordinates else {
            return
        }
        for coordinate in savedCoordinates {
            let cityWeather: CurrentWeatherData?
            do {
            cityWeather = try await networkService.getWeatherAsyncroniously(
                for: .coordinatesForCurrentWeatherCallApi(
                    latitude: CLLocationDegrees(Double(coordinate.latitude)),
                    longitude: CLLocationDegrees(Double(coordinate.longitude))
                ))
                let newElement = SearchDataModel(currentWeatherData: cityWeather!)!
                savedCities?.append(newElement)
            } catch {
                // TODO: Error handling
            }
        }
    }
    
    func deleteCoordinates(_ coordinate: Coordinates, completion: @escaping () -> Void) {
        StorageProvider.shared.deleteCoordinates(coordinate)
        completion()
    }
    
    func saveCoordinates(latitude: Double, longitude: Double) {
        StorageProvider.shared.saveCoordinates(lat: latitude, lon: longitude)
    }
}
