//
//  CurrentWeatherCellViewModelType.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation
import CoreLocation

protocol CurrentWeatherCellViewModelProtocol: AnyObject {
    var cityName: String { get }
    var currentTemp: String { get }
    var currentConditions: String { get }
    var currentMaxMinTempString: String { get }
    var latitude: CLLocationDegrees { get }
    var longitude: CLLocationDegrees { get }
}
