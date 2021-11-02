//
//  PaletteViewModelTests.swift
//  SwiftPaletteTests
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import XCTest
@testable import SwiftPalette

class PaletteViewModelTests: XCTestCase {
    
    let viewModel = PaletteViewModel()
    
    func hexColorStringTest() {
        let expectedReturn = "#F245FF"
        
        let currentReturn = viewModel.hexColorString(color: "F245FF")
        
        XCTAssertEqual(expectedReturn, currentReturn)
    }

}
