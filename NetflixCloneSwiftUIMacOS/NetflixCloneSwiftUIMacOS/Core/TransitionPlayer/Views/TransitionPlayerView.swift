//
//  TransitionPlayerView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 26.12.2022.
//

import SwiftUI
import AVKit

struct TransitionPlayerView: View {
    @State private var videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "netflix-intro-for-launch", withExtension: "mp4")!)
    var body: some View {
        ZStack{
            videoPlayerView
        }
        .frame(width: 992, height: 558)
        .background(.black)
    }
}
extension TransitionPlayerView{
    private var videoPlayerView : some View {
            VideoPlayer(player: videoPlayer)
                .frame(height: 329, alignment: .center)
                .onAppear{
                    videoPlayer.isMuted = true
                    videoPlayer.play()
                }
                .disabled(true)
    }
}
struct TransitionPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionPlayerView()
    }
}
