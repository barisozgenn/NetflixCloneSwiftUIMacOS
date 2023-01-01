//
//  PlayerViewModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 30.12.2022.
//

import AVKit
import SwiftUI

class PlayerViewModel: ObservableObject{
    private let randomDemoVideos = [URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!,
                                    URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!]
    var timeObserverToken: Any?

    @Published var videoPlayer : AVPlayer
    @Published var videoDuration : String = "00:00:00"
    @Published var videoCurrentTime : Double = 0
    @Published var videoTimeLeft : Double = 1
    @Published var videoTotalSeconds : Double = 1
    @Published var videIsPlaying: Bool = true
    @Published var videoVolume : Double = 1
    @Published var videoFrame : (width: CGFloat, height: CGFloat) = (1192,672)
    @Published var isFrameFullScreen : Bool = false
    init(){
        videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "netflix-intro-for-movie", withExtension: "mp4")!)
        videoPlayer.actionAtItemEnd = .pause
        // first show demo netflix video than select a random demo movie

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: videoPlayer.currentItem)
        videoPlayer.play()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        removePeriodicTimeObserver()
        videoPlayer.seek(to: CMTime.zero)
        videoPlayer.replaceCurrentItem(with: AVPlayerItem(url: randomDemoVideos.randomElement()!))
        videoPlayer.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
            let totalSeconds = self.videoPlayer.currentItem?.duration.seconds ?? 0
            self.videoCurrentTime = 0
            self.videoTotalSeconds = totalSeconds
            self.videoTimeLeft = totalSeconds
            let (hh,mm,ss) = self.modifyVideoTime(totalSeconds)
            self.videoDuration = "\(hh):\(mm):\(ss)"
            self.addPeriodicTimeObserver()
        }
    }
    
    private func modifyVideoTime(_ seconds: Double) -> (String,String,String) {
        let secondsInt = Int(seconds)
        let (h,m,s) = (secondsInt / 3600, (secondsInt % 3600) / 60, (secondsInt % 3600) % 60)
        let hh = h < 10 ? "0\(h)" : String(h)
        let mm = m < 10 ? "0\(m)" : String(m)
        let ss = s < 10 ? "0\(s)" : String(s)
        return (hh,mm,ss)
    }
    
    func addPeriodicTimeObserver() {
        // Notify every second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.29, preferredTimescale: timeScale)

        timeObserverToken = videoPlayer.addPeriodicTimeObserver(forInterval: time,
                                                          queue: .main) {
            [weak self] time in
            // update player transport UI
            self?.videoCurrentTime = time.seconds
            self?.updateVideoDuration()
            self?.setFrameSize()
        }
    }
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            videoPlayer.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }

    func updateVideoDuration(){
        videoTimeLeft = videoTotalSeconds - videoCurrentTime
        if videoTimeLeft > 0 {
            let (hh,mm,ss) = modifyVideoTime(videoTimeLeft)
            videoDuration = "\(hh):\(mm):\(ss)"
        }
    }
    
    func videoPlayStop(){
        withAnimation(.spring()){
            if videIsPlaying {
                videoPlayer.pause()
                videIsPlaying = false
            }else {
                videoPlayer.play()
                videIsPlaying = true
            }
        }
    }
    
    func videoChangeTime(isForward: Bool = true){
        let nextSeconds = isForward ? videoCurrentTime+10 : videoCurrentTime-10
        let timeCM = CMTime(seconds: nextSeconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        videoPlayer.seek(to: timeCM)
        
    }
    
    func setVideoVolume(){
        videoPlayer.volume = Float(videoVolume)
    }
    
    func setFrameSize(){
        let frameSize = videoPlayer.currentItem!.presentationSize
        let fullScreenSize : (width: CGFloat, height: CGFloat) = ( NSScreen.main!.frame.width, NSScreen.main!.frame.width)
       
        withAnimation(.spring()){
            videoFrame = isFrameFullScreen ? fullScreenSize : (frameSize.width, frameSize.height)
        }
    }
}
