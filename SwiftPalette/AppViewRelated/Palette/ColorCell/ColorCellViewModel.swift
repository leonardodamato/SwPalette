//
//  ColorCellViewModel.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-24.
//

import Foundation
import UIKit

struct ColorCellViewModel {
    
    var color: String
    
    init(color: String) {
        self.color = color
    }
    
    
    var hexColor: String {
        return "#\(color)"
    }
    
    var uiColor: String {
        let color = HexToUIColor.convert(hex: color).rgba
        return "UIColor(red: \(color.red), green: \(color.green), blue: \(color.blue), alpha: \(color.alpha))"
    }
    
    var secondsShowingColorInformation: Double {
        return 1.5
    }
    
    
    ///Copy Hex Button
    ///
    var copyHexButtonText: String {
        return "Copy HEX"
    }
    
    
    ///Copy UIColor Button
    ///
    var copyUIColorButtonText: String {
        return "Copy UIColor"
    }
    
    
    func setTintColor(for bgColor: UIColor) -> UIColor {
        return bgColor.isDarkColor ? .white : .black
    }
}
