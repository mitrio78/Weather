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
            self.currentLocationResult = SearchDataModel(currentWeatherData: data)
            completion(currentLocationResult!)
        }
    }
    
    func fetchSavedCities(completion: @escaping () -> Void) {
        savedCoordinates = StorageProvider.shared.getAllCoordinates()
        savedCities = []
        guard let savedCoordinates = savedCoordinates else {
            return
        }
        let mainQueue = DispatchQueue.main
        let group = DispatchGroup()
        for coordinate in savedCoordinates {
            
            // TODO: BUG! Needs to be sync!
            print("Coord")
            group.enter()
            self.networkService.fetchWeather(
                request: .coordinatesForCurrentWeatherCallApi(
                    latitude: CLLocationDegrees(Double(coordinate.latitude)),
                    longitude: CLLocationDegrees(Double(coordinate.longitude))
                )) { [weak self] (data) in
                    
                    guard let data = data else {
                        fatalError("Failed to recieve data from request")
                    }
                    print("City")
                    self?.savedCities!.append(SearchDataModel(currentWeatherData: data)!)
                    group.leave()
                }
        }
        group.notify(queue: mainQueue) {
            completion()
        }
    }
    
    func deleteCoordinates(_ coordinate: Coordinates, completion: @escaping () -> Void) {
        print("Deleting latitude: \(coordinate.latitude)")
        StorageProvider.shared.deleteCoordinates(coordinate)
        completion()
    }
    
    func saveCoordinates(latitude: Double, longitude: Double) {
        StorageProvider.shared.saveCoordinates(lat: latitude, lon: longitude)
    }
}
