//
//  SearchTableViewViewModelProtocol.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation
import CoreLocation

protocol LocationCoordinatesProtocol {
    var latitude: CLLocationDegrees { get }
    var longitude: CLLocationDegrees { get }
}

protocol SearchTableViewViewModelProtocol {
    var searchResult: SearchDataModel? { get set }
    var currentLocation: LocationCoordinatesProtocol? { get set }
    var savedCities: [SearchDataModel]? { get set }
    
    var networkService: NetworkService<CurrentWeatherData> { get set }
    func fetchSearchData(searchText: String, completion: @escaping () -> ())
    func fetchLocationData(location: LocationCoordinates, completion: @escaping (SearchDataModel) -> ())
    func fetchSavedCities()
}
