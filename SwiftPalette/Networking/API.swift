//
//  API.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import Foundation

struct API {
    
    
    private enum Endpoints: String {
        case randomPalette = "palettes/random"
        case palette = "palette"
    }
    
    
    ///Creates an URL for a random palette generation:
    ///"https://www.colourlovers.com/api/palettes/random?format=json"
    ///
    static func createRandomPaletteURL() -> URL {
        let rootURL = "https://www.colourlovers.com/api"
        let formatJson = "format=json"
        
        let url = "\(rootURL)/\(Endpoints.randomPalette.rawValue)?\(formatJson)"
        
        return URL(string: url)!
    }
    
    
    ///Creates an URL for a specific palette according to their ID
    ///"http://www.colourlovers.com/api/palette/398127?format=json"
    ///
    static func createPaletteURL(for id: Int) -> URL {
        let rootURL = "https://www.colourlovers.com/api"
        let formatJson = "format=json"

        let url = "\(rootURL)/\(Endpoints.palette.rawValue)/\(String(id))?\(formatJson)"

        return URL(string: url)!
    }
    
    
}
