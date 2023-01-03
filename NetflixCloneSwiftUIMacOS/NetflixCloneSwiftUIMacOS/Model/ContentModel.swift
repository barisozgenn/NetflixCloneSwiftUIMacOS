//
//  ContentModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 29.12.2022.
//

import Foundation

// MARK: - ContentModel
struct ContentModel: Identifiable, Codable {
    let id: String
    let name, imageBase64: String
    let maturityRatings, genres, categories: [String]
    let year: String
    let artists: [String]
    let match: String
    let episodes: [Episode]
}

// MARK: - Episode
struct Episode: Identifiable, Codable {
    let id: String
    let episodeDescription: String
    let durationInMinute: Int
    let videoURL: String
}
