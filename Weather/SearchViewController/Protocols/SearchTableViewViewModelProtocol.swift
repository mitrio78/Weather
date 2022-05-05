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
    //location
    var currentLocation: LocationCoordinatesProtocol? { get set }
    //data
    var searchResult: SearchDataModel? { get set }
    var savedCities: [SearchDataModel]? { get set }
    var currentLocationResult: SearchDataModel? { get set }
    //API
    var networkService: NetworkService<CurrentWeatherData> { get }
    //fetchData
    func fetchSearchData(searchText: String, completion: @escaping () -> ())
    func fetchLocationData(location: LocationCoordinates, completion: @escaping (SearchDataModel) -> ())
    func fetchSavedCities(completion: @escaping () -> Void)
    //CoreData
    func saveCoordinates(latitude: Double, longitude: Double, completion: @escaping () -> Void)
    func deleteCoordinates(from indexPath: IndexPath, completion: @escaping () -> Void) 
}
