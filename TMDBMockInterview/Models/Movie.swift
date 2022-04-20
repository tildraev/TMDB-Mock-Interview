//
//  Movie.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    
    let results: [Movie]
    let total_pages: Int?
}

struct Movie: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case overview
        case rating = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    var title: String?
    var rating: Double?
    var releaseDate: String?
    var overview: String?
    var posterPath: String?
}
