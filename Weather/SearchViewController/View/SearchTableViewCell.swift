//
//  SearchViewCell.swift
//  Weather
//
//  Created by Mitrio on 04.05.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let searchCellId = "SearchCell"
    var latitude: Double?
    var longitude: Double?
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func addCity(_ sender: Any) {
    }
    
}
