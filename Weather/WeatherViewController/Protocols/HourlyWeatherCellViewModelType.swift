//
//  HourlyWeatherCellViewModelType.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//
import UIKit

protocol HourlyWeatherCellViewModelType: AnyObject {
    var hour: String { get }
    var weatherIcon: UIImage { get }
    var hourlyTemperature: String { get }
}
