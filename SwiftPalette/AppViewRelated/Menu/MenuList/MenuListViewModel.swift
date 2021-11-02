//
//  MenuListViewModel.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import Foundation

class MenuListViewModel {
    
    //MARK: - TableView Related
    var numberOfRowsInSection: Int {
        return 1
    }
    
    var labelText: String {
        return "My Palettes"
    }
}
