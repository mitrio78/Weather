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
}
