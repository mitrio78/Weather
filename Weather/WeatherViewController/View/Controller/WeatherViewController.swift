//
//  WeatherViewController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit
import CoreLocation

final class WeatherViewController: UITableViewController {
    
    var viewModel: WeatherViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.getNewCoordinates(_:)), name: Notification.Name(rawValue: "changeCoordinates"), object: nil)
        registerCells()
        viewModel = WeatherTableViewViewModel()
        navigationController?.isNavigationBarHidden = true
        viewModel?.coordinates = LocationCoordinates(latitude: 55.7558, longitude: 37.6176)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWeather()
    }
    
    @objc func getNewCoordinates(_ notification: NSNotification) {
        if let incomeCoordinates = notification.userInfo {
            let lat = incomeCoordinates["lat"] as! Double
            let lon = incomeCoordinates["lon"] as! Double
            viewModel?.coordinates = LocationCoordinates(latitude: CLLocationDegrees(Float(lat)), longitude: CLLocationDegrees(Float(lon)))
        }
    }
    
    private func updateWeather() {
        viewModel?.fetchCurrentWeather { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private func сonfigureCellInSections(for indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let section = WeatherTableViewState.WeatherSection(rawValue: indexPath.section) else {
            fatalError("Section index out of range")
        }
        guard let viewModel = viewModel else {
            //TODO: Alert Controller
            return UITableViewCell()
        }
        let identifier = section.cellIdentifier(for: indexPath.row)
        switch section {
        case .currentWeather:
            let currentWeatherCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CurrentWeatherCell
            currentWeatherCell.configure(viewModel: viewModel)
            return currentWeatherCell
        case  .hourlyForecast:
            let hourlyWeatherCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HourlyForecastCell
            hourlyWeatherCell.configure(viewModel.hourlyWeatherCellViewModel)
            return hourlyWeatherCell
        case .dailyForecast:
            let dailyForecastCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DailyForecastCell
            guard let dailyWeather = viewModel.dailyWeatherCellViewModel else {
                print("No data in [DailyProtocol]")
                return dailyForecastCell
            }
            dailyForecastCell.setupDailyCell(for: indexPath, with: dailyWeather)
            return dailyForecastCell
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
}
// MARK: - TableView DataSource

extension WeatherViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = WeatherTableViewState.WeatherSection(rawValue: section) else { return 0 }
        switch section {
        case .currentWeather, .hourlyForecast:
            return 1
        case .dailyForecast:
            return viewModel?.dailyWeatherCellViewModel?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        сonfigureCellInSections(for: indexPath, from: tableView)
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
            guard let numberOfRows = viewModel?.dailyWeatherCellViewModel?.count else { return "" }
            return "Прогноз на \(numberOfRows) дней"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = WeatherTableViewState.WeatherSection(rawValue: indexPath.section) else { return 0 }
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

