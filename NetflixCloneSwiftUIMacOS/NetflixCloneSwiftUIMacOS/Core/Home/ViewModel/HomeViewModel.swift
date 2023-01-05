//
//  HomeViewModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 27.12.2022.
//

import AVKit
import RealmSwift
class HomeViewModel: ObservableObject {
    @Published var contentList: [ListModel] = []
    @Published var headerVideoPlayer = AVPlayer(url: Bundle.main.url(forResource: "avatar-intro", withExtension: "mp4")!)
    @ObservedResults(ContentRealmModel.self) var contents
    let service = ContentService()
    
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
        setContentListModel()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        headerVideoPlayer.seek(to: CMTime.zero)
    }
    
    func setContentListModel(){
        let contentTitles: [String] = ["Trending Now","Top Picks For You", "Only on Netflix","Watch In One Weekend"]
        for title in contentTitles {
            contentList.append(ListModel(title: title, contents: listToArray().shuffled()))
        }
    }
    
    func listToArray() -> [ContentRealmModel] {
        return contents.sorted(by: { (l, r) -> Bool in
            return l.name > r.name
        })
    }
}
