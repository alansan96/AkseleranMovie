//
//  MovieResponse.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import Foundation



// MARK: - Movie
struct MovieResponse : Decodable {
    let results: [Result]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
}

// MARK: - Dates
struct Dates : Decodable {
    let maximum, minimum: String?
}

// MARK: - Result
struct Result : Decodable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath, originalLanguage, originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?
}

struct MovieModel {
    var id: Int
    var title: String
    var posterlink: String
    
    
    init(id: Int, title: String, posterlink: String) {
        self.id = id
        self.title = title
        self.posterlink = "https://image.tmdb.org/t/p/w500" + posterlink
    }
    
    
}
