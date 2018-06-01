//
//  Album.swift
//  ItunesSearch
//
//  Created by Adam on 01/06/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation

struct TopLevelData: Codable {
    let results: [Album]
}

struct Album: Codable {
    let collectionName : String
    let artistName : String
    let primaryGenreName : String
    let trackCount : Int
    let trackPrice : Double
    let artWorkUrlString : String
    
    enum CodingKeys: String, CodingKey {
        case collectionName
        case artistName
        case primaryGenreName
        case trackCount
        case trackPrice
        case artWorkUrlString = "artworkUrl100"
    }
}
