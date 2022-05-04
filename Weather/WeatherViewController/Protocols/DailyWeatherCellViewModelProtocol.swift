//
//  DailyWeatherCellViewModelType.swift
//  Weather
//
//  Created by Mitrio on 26.04.2022.
//
import Foundation

protocol DailyWeatherCellViewModelProtocol: AnyObject {
    var date: String { get }
    var dailyMaxTemp: String { get }
    var dailyMinTemp: String { get }
    var dailyWeatherId: Int { get }
    var dailyHumidity: String { get }
}
