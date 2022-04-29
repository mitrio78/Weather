//
//  WeatherViewController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit
//import Pods_Weather

class WeatherViewController: UITableViewController {
    
    var viewModel: WeatherViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel = WeatherTableViewViewModel()
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
    }
    
    private func dequeueAndConfigureCell(for indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let section = WeatherTableViewState.WeatherSection(rawValue: indexPath.section) else {
            fatalError("Section index out of range")
        }
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        let identifier = section.cellIdentifier(for: indexPath.row)
        switch section {
        case .currentWeather:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CurrentWeatherCell
            cell.currentViewModel = viewModel.getCurrentWeatherCellViewModel()
            return cell
        case  .hourlyForecast:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HourlyForecastCell
            return cell
        case .dailyForecast:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DailyForecastCell
            setupDailyCell(cell: cell, for: indexPath)
            return cell
        }
    }
    
    private func registerCells() {
        let nibCW = UINib(nibName: "CurrentWeatherCell", bundle: nil)
        let nibHW = UINib(nibName: "HourlyForecastCell", bundle: nil)
        let nibDW = UINib(nibName: "DailyForecastCell", bundle: nil)
        tableView.register(nibCW, forCellReuseIdentifier: "CurrentWeatherCell")
        tableView.register(nibHW, forCellReuseIdentifier: "HourlyForecastCell")
        tableView.register(nibDW, forCellReuseIdentifier: "DailyForecastCell")
    }
    //TODO: do it in ViewModel
    private func setupDailyCell(cell: DailyForecastCell,for indexPath: IndexPath) {
        guard let weather = viewModel?.dailyWeatherData else {
            return
        }
        cell.dailyHumidity.text = "\(weather[indexPath.row].dHumidityString)%"
        cell.dailyImageView.image = weather[indexPath.row].weatherIcon
        cell.dailyMaxTempLabel.text = weather[indexPath.row].dMaxTempString
        cell.dailyMinTempLabel.text = weather[indexPath.row].dMinTempString
        cell.dayLabel.text = weather[indexPath.row].dateStrind
    }
}
// MARK: - TableView DataSource

extension WeatherViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = WeatherTableViewState.WeatherSection(rawValue: section) else { return 0 }
        switch section {
        case .currentWeather, .hourlyForecast:
            return 1
        case .dailyForecast:
            return viewModel?.numberOfRowsInDailyWeatherSection() ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dequeueAndConfigureCell(for: indexPath, from: tableView)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        WeatherTableViewState.WeatherSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = WeatherTableViewState.WeatherSection(rawValue: section) else {
            fatalError("Section index out of range")
        }
        switch section {
        case .currentWeather, .hourlyForecast:
            return section.displayText
        case .dailyForecast:
            guard let numberOfRows = viewModel?.numberOfRowsInDailyWeatherSection() else { return "" }
            return "Прогноз на \(numberOfRows) дней"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = WeatherTableViewState.WeatherSection(rawValue: indexPath.section) else { return 0}
        switch section {
        case .currentWeather:
            return 280
        case .hourlyForecast:
            return 80
        case .dailyForecast:
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
    
