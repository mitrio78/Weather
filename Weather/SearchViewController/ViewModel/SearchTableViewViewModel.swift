//
//  SearchTableViewViewModel.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation
import CoreLocation

class SearchTableViewViewModel: SearchTableViewViewModelProtocol {
    
    var savedCoordinates: [Coordinates]?
    var savedCities: [SearchDataModel]?
    var currentLocation: LocationCoordinatesProtocol?
    var searchResult: SearchDataModel?
    var currentLocationResult: SearchDataModel?
    var networkService = NetworkService<CurrentWeatherData>()
    
    func fetchSearchData(searchText: String, completion: @escaping () -> ()) {
        self.networkService.fetchWeather(request: .cityName(city: searchText)) { [unowned self] (result) in
            guard let result = result else {
                searchResult = nil
                completion()
                return
            }
            self.searchResult = SearchDataModel(currentWeatherData: result)
            completion()
        }
    }
    
    func fetchLocationData(location: LocationCoordinates, completion: @escaping (SearchDataModel) -> ()) {
        guard let currentLocation = currentLocation else {
            print("no location")
            return
        }
        self.networkService.fetchWeather(request: .coordinatesForCurrentWeatherCallApi(latitude: currentLocation.latitude, longitude: currentLocation.longitude)) { [unowned self] (data) in
            guard let data = data else {
                print("no data")
                return
            }
            print("LOCATIONAMA!")
            self.currentLocationResult = SearchDataModel(currentWeatherData: data)
            completion(currentLocationResult!)
        }
    }
    
    func fetchSavedCities(completion: @escaping () -> Void) {
        savedCoordinates = StorageProvider.shared.getAllCoordinates()
        savedCities = []
        guard let savedCoordinates = savedCoordinates else {
            print("no saved coords in vm")
            return
        }
        for savedCoordinate in savedCoordinates {
            self.networkService.fetchWeather(request: .coordinatesForCurrentWeatherCallApi(latitude: CLLocationDegrees(Float(savedCoordinate.latitude)) , longitude: CLLocationDegrees(Float(savedCoordinate.longitude)) )) { [unowned self] (data) in
                guard let data = data else {
                    print("Failed to fetch saved city data")
                    return
                }
                self.savedCities!.append(SearchDataModel(currentWeatherData: data)!)
                completion()
            }
        }
    }
    
    func deleteCoordinates(from indexPath: IndexPath, completion: @escaping () -> Void) {
        guard let coordinate = savedCoordinates?[indexPath.row] else { return }
        StorageProvider.shared.deleteCoordinates(coordinate)
        fetchSavedCities {
            completion()
        }
    }
    
    func saveCoordinates(latitude: Double, longitude: Double, completion: @escaping () -> Void) {
        StorageProvider.shared.saveCoordinates(lat: latitude, lon: longitude)
        fetchSavedCities {
            completion()
        }
    }
}
