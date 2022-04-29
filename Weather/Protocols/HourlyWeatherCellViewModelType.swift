//
//  HourlyWeatherCellViewModelType.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation
import UIKit

protocol HourlyWeatherCellViewModelType {
    var hour: String { get }
    var weatherIcon: UIImage { get }
    var hourlyTemperature: String { get }
}
