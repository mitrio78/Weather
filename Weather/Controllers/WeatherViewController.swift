//
//  WeatherViewController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit

protocol Presenter {

}

class WeatherViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    private func dequeueAndConfigureCell(for indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let section = WeatherDetailViewModel.WeatherSection(rawValue: indexPath.section) else {
            fatalError("Section index out of range")
        }
        let identifier = section.cellIdentifier(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        switch section {
        case .currentWeather:
            let cell = cell as! CurrentWeatherCell
            return cell
        case  .hourlyForecast:
            let cell = cell as! HourlyForecastCell
            return cell
        case .dailyForecast:
            let cell = cell as! DailyForecastCell
            return cell
        }
    }
    
    private func registerCells () {
        let nibCW = UINib(nibName: "CurrentWeatherCell", bundle: nil)
        let nibHW = UINib(nibName: "HourlyForecastCell", bundle: nil)
        let nibDW = UINib(nibName: "DailyForecastCell", bundle: nil)
        tableView.register(nibCW, forCellReuseIdentifier: "CurrentWeatherCell")
        tableView.register(nibHW, forCellReuseIdentifier: "HourlyForecastCell")
        tableView.register(nibDW, forCellReuseIdentifier: "DailyForecastCell")
    }
}

extension WeatherViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherDetailViewModel.WeatherSection(rawValue: section)?.numberOfRows ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dequeueAndConfigureCell(for: indexPath, from: tableView)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        WeatherDetailViewModel.WeatherSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = WeatherDetailViewModel.WeatherSection(rawValue: section) else {
            fatalError("Section index out of range")
        }
        return section.displayText
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = WeatherDetailViewModel.WeatherSection(rawValue: indexPath.section) else { return 0}
        switch section {
        case .currentWeather:
            return 320
        case .hourlyForecast:
            return 80
        case .dailyForecast:
            return 60
        }
    }
}
