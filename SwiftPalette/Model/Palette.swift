//
//  Palette.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import Foundation

// MARK: - PaletteElement
struct Palette: Codable {
    let id: Int
    let title, userName: String?
    let numViews, numVotes, numComments, numHearts: Int
    let rank: Int
    let dateCreated: String?
    let colors: [String]
    let paletteDescription: String?
    let url: String?
    let imageURL, badgeURL: String?
    let apiURL: String?

    enum CodingKeys: String, CodingKey {
        case id, title, userName, numViews, numVotes, numComments, numHearts, rank, dateCreated, colors
        case paletteDescription
        case url
        case imageURL
        case badgeURL
        case apiURL
    }
}
