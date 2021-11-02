//
//  MyPalettesCellViewModel.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import Foundation

class MyPalettesCellViewModel {
    
    var palette: Palette
    
    init(palette: Palette) {
        self.palette = palette
    }
    
    
    var colors: [String] {
        return palette.colors
    }
    
    var title: String {
        return palette.title ?? "Unknown Title"
    }
    
    var author: String {
        return "by \(palette.userName ?? "Unknown Author")"
    }
}
