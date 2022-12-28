//
//  HomeViewModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 27.12.2022.
//

import AVKit
class HomeViewModel: ObservableObject {
    @Published var contentTitles: [String] = ["Trending Now","Documentaries", "Only on Netflix","Watch In One Weekend"]
    @Published var headerVideoPlayer = AVPlayer(url: Bundle.main.url(forResource: "avatar-intro", withExtension: "mp4")!)
    
    init(){
        
        headerVideoPlayer.isMuted = true
        headerVideoPlayer.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: headerVideoPlayer.currentItem)
        headerVideoPlayer.play()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        headerVideoPlayer.seek(to: CMTime.zero)
    }
}
