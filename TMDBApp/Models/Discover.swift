//
//  Discover.swift
//  TMDBApp
//
//  Created by Pro on 27.03.2023.
//

import Foundation

struct Discover: Codable {
    let results: [Movie]
    let total_pages: Int
}

struct Movie: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String
    let vote_average: Float
    let genres: [Genre]?
}

struct Genre: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
}

