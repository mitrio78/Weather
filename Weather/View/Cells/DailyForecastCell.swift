//
//  DailyForecastCell.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit

class DailyForecastCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dailyMaxTempLabel: UILabel!
    @IBOutlet weak var dailyMinTempLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyHumidity: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
