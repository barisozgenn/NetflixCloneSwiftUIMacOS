//
//  HomeViewModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 27.12.2022.
//

import AVKit
import RealmSwift

class HomeViewModel: ObservableObject {
    @Published var contentTitles: [String] = ["Trending Now","Documentaries", "Only on Netflix","Watch In One Weekend"]
    @Published var headerVideoPlayer = AVPlayer(url: Bundle.main.url(forResource: "avatar-intro", withExtension: "mp4")!)
    @ObservedResults(ContentRealmModel.self) var contents
    lazy var service = ContentService()
    
    init(){
        headerVideoPlayer.isMuted = true
        headerVideoPlayer.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: headerVideoPlayer.currentItem)
        headerVideoPlayer.play()
        service.fetchContentsFromRealm()
        contents.forEach { item in
            print("ITEM: \(item.name) \(item.imageBase64.count)")
        }
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        headerVideoPlayer.seek(to: CMTime.zero)
    }
}
