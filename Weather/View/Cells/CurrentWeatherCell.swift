//
//  CurrentWeatherCell.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
            
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentConditionsLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentMaxMinTempLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    weak var currentViewModel: CurrentWeatherCellViewModelType? {
        willSet(currentViewModel) {
            guard let viewModel = currentViewModel else {
                print("willSet no currentViewModel")
                return
            }
            print("willSet currentViewModel")
            cityLabel.text = viewModel.cityName
            currentConditionsLabel.text = viewModel.currentConditions
            currentTempLabel.text = viewModel.currentTemp
            currentMaxMinTempLabel.text = viewModel.currentMaxMinTempString
        }
    }
}
