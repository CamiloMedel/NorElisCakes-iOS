//
//  UIColor+Extensions.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/12/25.
//

import Foundation
import UIKit

extension UIColor {
    /// UIColor extension method for converting a string in the format "R G B" ex. ("255 255 255") to a UIColor
    static func RGBSringTOUIColor(_ rgbString: String) -> UIColor {
        let RGBArray = rgbString.split(separator: " ")
        let red: CGFloat = CGFloat(Float(RGBArray[0])! / 255)
        let green: CGFloat = CGFloat(Float(RGBArray[1])! / 255)
        let blue: CGFloat = CGFloat(Float(RGBArray[2])! / 255)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
