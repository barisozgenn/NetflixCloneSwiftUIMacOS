//
//  ContentModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 29.12.2022.
//

import Foundation
import RealmSwift

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

class ContentRealmModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) dynamic var _id: String = UUID().uuidString
    @Persisted var name: String
    
    @Persisted var maturityRatings: List<String>
    @Persisted var genres: List<String>
    @Persisted var categories: List<String>
    
    @Persisted var year: String
    
    @Persisted var artists: List<String>
    
    @Persisted var match: String
    
    @Persisted var imageBase64: String
    
    @Persisted var episodes: List<EpisodeRealm>
    
    convenience init(name: String, maturityRatings: List<String>,
                     genres: List<String>,categories: List<String>,
                     year: String,artists: List<String>,
                     match: String,imageBase64: String, episodes: List<EpisodeRealm>) {
        self.init()
        self.name = name
        self.maturityRatings = maturityRatings
        self.genres = genres
        self.categories = categories
        self.year = year
        self.artists = artists
        self.match = match
        self.imageBase64 = imageBase64
        self.episodes = episodes
    }
}

class EpisodeRealm: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) dynamic var _id: String = UUID().uuidString
    @Persisted var episodeDescription: String
    @Persisted var durationInMinute: Int
    @Persisted var videoURL: String
    
    convenience init(episodeDescription: String, durationInMinute: Int,videoURL: String) {
        self.init()
        self.episodeDescription = episodeDescription
        self.durationInMinute = durationInMinute
        self.videoURL = videoURL
    }
}
