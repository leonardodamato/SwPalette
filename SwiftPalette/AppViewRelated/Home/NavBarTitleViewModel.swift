//
//  NavBarTitleViewModel.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import Foundation

class NavBarTitleViewModel {
    
    var palette: Palette
    
    init(palette: Palette) {
        self.palette = palette
    }
    
    
    var paletteTitle: String {
        return palette.title ?? "Unknown Title"
    }
    
    
    var paletteAuthor: String {
        return "by \(palette.userName ?? "Unknown author")"
    }
    
}
