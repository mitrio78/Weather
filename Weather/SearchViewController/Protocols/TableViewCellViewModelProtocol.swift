//
//  TableViewCellViewModelProtocol.swift
//  Weather
//
//  Created by Mitrio on 06.05.2022.
//

import Foundation

protocol SearchTableViewCellViewModelProtocol {
    var cityName: String { get }
    var temp: String { get }
    var weatherId: Int { get }
    var latitude: Double { get }
    var longitude: Double { get }
}
