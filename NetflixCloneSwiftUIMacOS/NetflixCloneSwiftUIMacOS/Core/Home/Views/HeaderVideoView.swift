//
//  HeaderVideoView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 27.12.2022.
//

import SwiftUI
import AVKit
struct HeaderVideoView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    var body: some View {
        ZStack{
            videoPlayerView
            Text("BARİS")
                .font(.title)
        }
        .frame(width: 1158, height: 650)
        .foregroundColor(.white)
        .offset(y:-158)
    }
}
extension HeaderVideoView{
    private var videoPlayerView : some View {
        AVPlayerRepresented(videoPlayer: viewModel.headerVideoPlayer)
            .frame(maxWidth: .infinity)
            .disabled(true)
            .background(.purple)
    }
}
struct HeaderVideoView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderVideoView()
            .environmentObject(HomeViewModel())
    }
}
