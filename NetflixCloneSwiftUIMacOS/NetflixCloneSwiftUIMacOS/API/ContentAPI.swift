//
//  ContentAPI.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 3.01.2023.
//

import Combine
import Foundation
class ContentService {
    static let shared = ContentService()
    lazy var contents : [ContentModel] = []
    
    init() {
        fetchFromJSON(forName: "movies")
    }
    private func fetchFromJSON(forName fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([ContentModel].self, from: data)
                    self.contents = jsonData
                } catch {
                    print("DEBUG: parsing json error:\(error)")
                }
            }
    }
}
