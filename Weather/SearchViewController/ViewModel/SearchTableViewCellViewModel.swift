//
//  SearchTableViewCellViewModel.swift
//  Weather
//
//  Created by Mitrio on 06.05.2022.
//

import Foundation

struct SearchTableViewCellViewModel: SearchTableViewCellViewModelProtocol {
    var searchViewWeather: SearchDataModel
    var cityName: String {
        return searchViewWeather.cityName
    }
    var temp: String {
        return searchViewWeather.tempString
    }
    var weatherId: Int {
        return searchViewWeather.weatherCode
    }
    var latitude: Double {
        return searchViewWeather.latitude
    }
    var longitude: Double {
        return searchViewWeather.longitude
    }
    init(searchWeather: SearchDataModel) {
        self.searchViewWeather = searchWeather
    }
}
