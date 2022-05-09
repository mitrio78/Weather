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
//            print("Location!")
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
        for coordinate in savedCoordinates {
            self.networkService.fetchWeather(request: .coordinatesForCurrentWeatherCallApi(latitude: CLLocationDegrees(Float(coordinate.latitude)), longitude: CLLocationDegrees(Float(coordinate.longitude)) )) { [unowned self] (data) in
                guard let data = data else {
                    print("Failed to fetch saved city data")
                    return
                }
                self.savedCities!.append(SearchDataModel(currentWeatherData: data)!)
                //savedCities = sort(cities: savedCities!, by: savedCoordinates)
                completion()
            }
        }
    }
    
    func deleteCoordinates(_ coordinate: Coordinates, completion: @escaping () -> Void) {
        StorageProvider.shared.deleteCoordinates(coordinate)
        completion()
    }
    
    func saveCoordinates(latitude: Double, longitude: Double, completion: @escaping () -> Void) {
        StorageProvider.shared.saveCoordinates(lat: latitude, lon: longitude)
        completion()
    }
    
    func sort(cities array1: [SearchDataModel], by array2: [Coordinates]) -> [SearchDataModel] {
        var tempArray: [SearchDataModel] = []
        for i in 0...array2.count-1 {
            for a in 0...array1.count-1 {
                if array2[i].latitude == array1[a].latitude && array2[i].longitude == array1[a].longitude {
                    tempArray.append(array1[a])
                }
            }
        }
        return tempArray
    }
}
