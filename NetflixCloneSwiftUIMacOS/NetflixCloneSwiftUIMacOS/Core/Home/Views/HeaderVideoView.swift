//
//  HeaderVideoView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 27.12.2022.
//

import SwiftUI
import AVKit
struct HeaderVideoView: View {
    private let videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "avatar-intro", withExtension: "mp4")!)
    var body: some View {
        ZStack{
            videoPlayerView
        }
    }
}
extension HeaderVideoView{
    private var videoPlayerView : some View {
        AVPlayerRepresented(videoPlayer: videoPlayer)
            .onAppear {
                videoPlayer.isMuted = true
                videoPlayer.play()
                videoPlayer.actionAtItemEnd = .none
            }
            .frame(maxWidth: .infinity)
            .disabled(true)
    }
}
struct HeaderVideoView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderVideoView()
    }
}
