//
//  UIColor+ext.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-25.
//

import Foundation
import UIKit

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        func roundNumber(value: CGFloat) -> CGFloat {
            let originalValue = value
            return round(originalValue * 100) / 100.0
        }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (roundNumber(value: red), roundNumber(value: green), roundNumber(value: blue), roundNumber(value: alpha))
    }
}
