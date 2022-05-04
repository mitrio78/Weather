//
//  HourlyWeatherCellViewModelType.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//
import Foundation

protocol HourlyWeatherCellViewModelProtocol: AnyObject {
    var hourString: String { get }
    var weatherId: Int { get }
    var hTempString: String { get }
}
