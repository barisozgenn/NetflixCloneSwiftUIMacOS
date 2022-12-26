//
//  TransitionPlayerView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 26.12.2022.
//

import SwiftUI
import AVKit

struct TransitionPlayerView: View {
    @StateObject private var viewModel = TransitionPlayerViewModel()
    @Binding var isVideoEnd: Bool
    
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
        AVPlayerRepresented(videoPlayer: viewModel.videoPlayer)
            .onAppear {
                viewModel.videoPlayer.isMuted = true
                viewModel.videoPlayer.play()
            }
            .onChange(of: viewModel.isVideoEnd, perform: { newValue in
                withAnimation(.spring()){
                    isVideoEnd = newValue
                }
            })
            .frame(height: 329)
            .scaleEffect(isVideoEnd ? 7 : 1)
            .opacity(isVideoEnd ? 0 : 1)
            .disabled(true)
    }
}
struct TransitionPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionPlayerView(isVideoEnd: .constant(false))
    }
}
