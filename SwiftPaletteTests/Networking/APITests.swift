//
//  APITests.swift
//  SwiftPaletteTests
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import XCTest
@testable import SwiftPalette

class APITests: XCTestCase {
    
    func testCreateRandomPaletteURL() {
        let expectedReturn = URL(string: "https://www.colourlovers.com/api/palettes/random?format=json")!
        
        let currentReturn = API.createRandomPaletteURL()
        
        XCTAssertEqual(expectedReturn, currentReturn)
        XCTAssertNotNil(currentReturn)
    }
    
    func testCreatePaletteURL() {
        let expectedReturn = URL(string: "https://www.colourlovers.com/api/palette/123456?format=json")!
        
        let currentReturn = API.createPaletteURL(for: 123456)
        
        XCTAssertEqual(expectedReturn, currentReturn)
        XCTAssertNotNil(currentReturn)
    }
}
