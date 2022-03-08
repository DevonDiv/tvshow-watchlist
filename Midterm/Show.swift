//
//  Show.swift
//  Midterm
//
//  Created by Devon Divinecz on 2022-03-07.
//

import Foundation

struct Shows: Codable {
    var results: [Show]
}

struct Show: Codable, Hashable {
    var id: Int
    var collectionName: String
    var image: String?
    var trackName: String
    var artistName: String
    var price: Double
    var description: String
}
