//
//  ContentAPI.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 3.01.2023.
//

import Combine
import Foundation
import RealmSwift

let realmApp = RealmSwift.App(id: "write-here-your-own-realm-app-id")

final class ContentService: ObservableObject {
    @ObservedResults(ContentRealmModel.self) var contents
    lazy var contentsJson: [ContentModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    public func fetchContentsFromRealm(){
        if let currentUser = realmApp.currentUser {
            var userConfig = currentUser.configuration(partitionValue: currentUser.id)
            userConfig.objectTypes = [ContentRealmModel.self, EpisodeRealm.self]
            
            Realm.asyncOpen(configuration: userConfig)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { result in
                    if case let .failure(error) = result {
                        print("DEBUG: Failed to open realm: \(error.localizedDescription)")
                    }
                }, receiveValue: {[weak self] _ in
                    if self?.contents.count ?? 0 < 1 {
                        self?.fetchContentsFromJSON(forName: "movies")
                    }
                    print("DEBUG: realm item counts: \(self?.contents.count ?? 0)")
                })
                .store(in: &cancellables)
        }else {
            auth()
        }
    }
    
    private func fetchContentsFromJSON(forName fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ContentModel].self, from: data)
                contentsJson = jsonData
                print("DEBUG: json item counts: \(contentsJson.count)")
                for content in contentsJson {
                    let realm = try! Realm()
                    try! realm.write {
                        let newContent = ContentRealmModel(name: content.name,
                                                           maturityRatings: List<String>(),
                                                           genres: List<String>(),
                                                           categories: List<String>(),
                                                           year: content.year,
                                                           artists: List<String>(),
                                                           match: content.match,
                                                           imageBase64: content.imageBase64,
                                                           episodes: List<EpisodeRealm>())
                        
                        content.maturityRatings.forEach{item in
                            newContent.maturityRatings.append(item)
                        }
                        content.genres.forEach{item in
                            newContent.genres.append(item)
                        }
                        content.categories.forEach{item in
                            newContent.categories.append(item)
                        }
                        content.artists.forEach{item in
                            newContent.artists.append(item)
                        }
                        content.episodes.forEach { item in
                            let episode = EpisodeRealm(episodeDescription: item.episodeDescription, durationInMinute: item.durationInMinute, videoURL: item.videoURL)
                            newContent.episodes.append(episode)
                        }
                        realm.add(newContent)
                    }
                }
                fetchContentsFromRealm()
            } catch {
                print("DEBUG: parsing json error:\(error)")
            }
        }
    }
    private func auth() {
        realmApp.login(credentials: .anonymous)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    print("DUBUG: Realm Error: \(error.localizedDescription)")
                }
            }, receiveValue: {[weak self] _ in
                    self?.fetchContentsFromRealm()
            })
            .store(in: &cancellables)
    }
}
