//
//  DailyWeatherCellViewModelType.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//

import Foundation
import UIKit

protocol DailyWeatherCellViewModelType {
    var date: String { get }
    var dailyMaxTemp: String { get }
    var dailyMinTemp: String { get }
    var dailyWeatherIcon: UIImage { get }
    var dailyHumidity: String { get }
}
