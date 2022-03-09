//
//  Show.swift
//  Midterm
//
//  Created by Devon Divinecz on 2022-03-07.
//

import Foundation

//Shows struct to hold the results of all the shows from the search
struct Shows: Codable {
    var results: [Show]
}

//Show struct to call all the properties from api request
struct Show: Codable, Hashable {
    var collectionId: Int
    var collectionName: String
    var artworkUrl100: String?
    var trackName: String
    var artistName: String
    var trackPrice: Double
    var longDescription: String
    var trackViewUrl: String
    var contentAdvisoryRating: String
}
