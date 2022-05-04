//
//  Color.swift
//  IMusic
//
//  Created by Mitrio on 04.04.2022.
//

import UIKit

extension UIColor {
    
    convenience init (red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && red <= 255, "Invalid green component")
        assert(blue >= 0 && red <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1.0)
    }
    
    convenience init (rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
