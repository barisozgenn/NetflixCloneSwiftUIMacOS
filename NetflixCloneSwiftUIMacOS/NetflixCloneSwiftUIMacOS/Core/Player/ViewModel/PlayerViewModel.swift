//
//  PlayerViewModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 30.12.2022.
//

import AVKit
class PlayerViewModel: ObservableObject{
    private let randomDemoVideos = [URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!]
    
    @Published var videoPlayer : AVPlayer
    
    init(){
        videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "netflix-intro-for-movie", withExtension: "mp4")!)
        videoPlayer.actionAtItemEnd = .pause
        // first show demo netflix video than select a demo movie
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: videoPlayer.currentItem)
        videoPlayer.play()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        print("Player Item: \(videoPlayer.currentItem!)")
        videoPlayer.seek(to: CMTime.zero)
        videoPlayer.replaceCurrentItem(with: AVPlayerItem(url: randomDemoVideos.randomElement()!))
        videoPlayer.play()
    }
}
