//
//  DailyWeatherCellViewModel.swift
//  Weather
//
//  Created by Mitrio on 29.04.2022.
//

import Foundation

class DailyWeatherCellViewModel: DailyWeatherCellViewModelProtocol {
    
    var date: String
    
    var dailyMaxTemp: String
    
    var dailyMinTemp: String
        
    var dailyWeatherId: Int
    
    var dailyHumidity: String
    
    init(model: DailyWeatherModel) {
        self.date = model.dateStrind
        self.dailyHumidity = model.dHumidityString
        self.dailyWeatherId = model.weatherCode
        self.dailyMinTemp = model.dMinTempString
        self.dailyMaxTemp = model.dMaxTempString
    }
}
