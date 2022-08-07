//
//  NetworkSettings.swift
//  Weather
//
//  Created by Mitrio on 03.05.2022.
//

import Foundation

struct NetworkSettings {
    static let apiKey = "99036c111dc2331bd211f348a9c37088"
    static let lang = "ru"
    static let body = "https://api.openweathermap.org/data/2.5/"
    static let oneCallApi = "onecall?"
    static let currentWeatherApi = "weather?"
}

enum APIError: Error, Codable {
    case wrongUrl
    case dataTaskError(descriprion: String)
    case invalidResponseStatus
    case JSONDecoderError(descriprion: String)
}
