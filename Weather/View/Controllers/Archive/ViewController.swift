//
//  ViewController.swift
//  Weather
//
//  Created by Mitrio on 04.04.2022.
//

//import UIKit
//
//class ViewController: UIViewController {
//
//    var networkManager = NetworkManager()
//    let cityName = "Moscow"
//
//    @IBOutlet weak var currentPlaceLabel: UILabel!
//    @IBOutlet weak var currentTempLabel: UILabel!
//    @IBOutlet weak var currentConditionsLabel: UILabel!
//    @IBOutlet weak var minMaxTempLabel: UILabel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        updateViews()
//    }
//
//    func updateViews() {
//        networkManager.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
//        networkManager.onCompletion = { [unowned self] currentWeather in
//            self.updateInterfaceWith(weather: currentWeather)
//        }
//    }
//
//    func updateInterfaceWith(weather: CurrentWeatherModel) {
//        DispatchQueue.main.async {
//            self.currentPlaceLabel.text = weather.location
//            self.currentTempLabel.text = weather.tempString
//            self.minMaxTempLabel.text = "Мин.: \(weather.minTempString), макс.: \(weather.maxTempString)"
//            self.currentConditionsLabel.text = weather.conditions
//        }
//    }
//}

