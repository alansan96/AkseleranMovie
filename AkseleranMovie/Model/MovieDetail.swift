//
//  MovieDetail.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import Foundation


// MARK: - Movie
struct MovieDetail : Decodable {
    let backdropPath: String?
    let genres: [Genre]?
    let id: Int?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let voteCount: Int?
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int?
    let name: String?
}


// MARK: - Caster
struct Caster: Decodable {
    let cast: [Cast]?
}

// MARK: - Cast
struct Cast: Decodable {
    let profilePath: String?
}
