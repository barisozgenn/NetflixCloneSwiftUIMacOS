//
//  ContentExpandedViewModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 2.01.2023.
//

import AVKit
import SwiftUI
import RealmSwift

class ContentExpandedViewModel:ObservableObject{
    @Published var videoPlayer : AVPlayer
    @Published var isVideoReadyToPlay : Bool = false
    @Published var videoFrame : (width: CGFloat, height: CGFloat) = (629,353.81)
    @ObservedResults(ContentRealmModel.self) var contents
    @ObservedRealmObject var content: ContentRealmModel = ContentRealmModel()
    
    private let randomDemoVideos = [URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!]
    var timeObserverToken: Any?
    
    init(){
        videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "netflix-intro-for-movie", withExtension: "mp4")!)
        videoPlayer.actionAtItemEnd = .pause
        setupPlayer()
        content = contents.first!
    }
    
    deinit {
        print("ContentExpandedViewModel: deinit")
    }
    private func setupPlayer(){
        removePeriodicTimeObserver()
        videoPlayer.actionAtItemEnd = .pause
        videoPlayer.replaceCurrentItem(with: AVPlayerItem(url: randomDemoVideos.randomElement()!))
        videoPlayer.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
            let totalSeconds = self.videoPlayer.currentItem?.duration.seconds ?? 0
            self.videoPlayer.seek(to: CMTime(seconds: totalSeconds/2, preferredTimescale: 1))
            self.videoPlayer.pause()
            self.addPeriodicTimeObserver()
            
        }
    }
    
    private func addPeriodicTimeObserver() {
        // Notify every second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.29, preferredTimescale: timeScale)
        
        timeObserverToken = videoPlayer.addPeriodicTimeObserver(forInterval: time,
                                                                queue: .main) {
            [weak self] _ in
            // update player transport UI
            withAnimation(.spring()){
                self?.isVideoReadyToPlay = true
                self?.setFrameSize()
            }
        }
    }
    private func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            videoPlayer.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    func setFrameSize(){
        let frameSize = videoPlayer.currentItem!.presentationSize
        videoFrame = (629, frameSize.width < 720 ? 290 : 353.81)
    }
}
