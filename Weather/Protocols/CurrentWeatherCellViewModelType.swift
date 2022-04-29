//
//  CurrentWeatherCellViewModelType.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation

protocol CurrentWeatherCellViewModelType: AnyObject {
    var cityName: String { get }
    var currentTemp: String { get }
    var currentConditions: String { get }
    var currentMaxMinTempString: String { get }
}
