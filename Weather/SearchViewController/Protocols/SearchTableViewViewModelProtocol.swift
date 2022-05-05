//
//  SearchTableViewViewModelProtocol.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation
import CoreLocation

protocol LocationCoordinatesProtocol {
    var latitude: CLLocationDegrees { get set }
    var longitude: CLLocationDegrees { get set }
}

protocol SearchTableViewViewModelProtocol {
    var searchResult: SearchDataModel? { get set }
    var currentLocation: LocationCoordinatesProtocol? { get set }
    var savedCities: [SearchDataModel]? { get set }
    var savedCoordinates: [Coordinates]? { get set }
    
    var networkService: NetworkService<CurrentWeatherData> { get set }
    
    func fetchSearchData(searchText: String, completion: @escaping () -> ())
    func fetchLocationData(location: LocationCoordinates, completion: @escaping (SearchDataModel) -> ())
    func fetchSavedCities(completion: @escaping () -> Void)
    
    func saveCoordinates(latitude: Double, longitude: Double, completion: @escaping () -> Void)
    func deleteCoordinates(from indexPath: IndexPath, completion: @escaping () -> Void) 
}
