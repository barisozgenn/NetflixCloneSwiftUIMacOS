//
//  PlayerView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 30.12.2022.
//

import SwiftUI

struct PlayerView: View {
    @StateObject private var viewModel = PlayerViewModel()
    @State private var isControlPanelVisible = false
    @State private var isFullScreen = false
    var body: some View {
        ZStack{
            videoPlayerView
            controlPanelView
        }
    }
}
extension PlayerView{
    private var videoPlayerView : some View {
        AVPlayerRepresented(videoPlayer: viewModel.videoPlayer)
            .frame(maxWidth: .infinity)
            .disabled(true)
            .background(.purple)
            .onAppear{
                withAnimation(.spring()){isControlPanelVisible=true}
            }
    }
    private var controlPanelView: some View {
        VStack(spacing:20){
            HStack{
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                Spacer()
                Image(systemName: "flag")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
            }
            .padding(.horizontal)
            Spacer()
            HStack{
                Slider(value: $viewModel.videoCurrentTime, in: 0...viewModel.videoTotalSeconds)
                    .tint(.red)
                Text("\(viewModel.videoDuration)")
                    .font(.headline)
            }
            HStack{
                HStack(spacing:29){
                    Image(systemName: "play.fill")
                        .resizable()
                        .withPlayerButtonModifier(frameHeight: 27)
                    Image(systemName: "gobackward.10")
                        .resizable()
                        .withPlayerButtonModifier(frameHeight: 29)
                    Image(systemName: "goforward.10")
                        .resizable()
                        .withPlayerButtonModifier(frameHeight: 29)
                    Image(systemName: "speaker.wave.3.fill")
                        .resizable()
                        .withPlayerButtonModifier()
                }
                Text("Content title: Episode title")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                HStack(spacing:29){
                    Image(systemName: "forward.end")
                        .resizable()
                        .withPlayerButtonModifier()
                    Image(systemName: "rectangle.on.rectangle")
                        .resizable()
                        .withPlayerButtonModifier()
                    Image(systemName: "text.bubble")
                        .resizable()
                        .withPlayerButtonModifier()
                    Image(systemName: "stopwatch")
                        .resizable()
                        .withPlayerButtonModifier()
                    Image(systemName: "rectangle.dashed")
                        .resizable()
                        .withPlayerButtonModifier()
                        .onTapGesture {
                            withAnimation(.spring()){
                                if let window = NSApplication.shared.windows.last {
                                    window.toggleFullScreen($isFullScreen)
                                }
                            }
                        }
                }
                .padding(.bottom, 29)
            }
            .shadow(color: .black.opacity(0.29), radius: 3, x: 1, y: 1)
            .fontWeight(.bold)
        }
        .scaleEffect(y: isControlPanelVisible ? 1 : 1.4)
        .opacity(isControlPanelVisible ? 1 : 0)
        .foregroundColor(.white)
        .padding()
        .background(content: {
            LinearGradient(colors: [.black.opacity(0.92),
                                    .clear,
                                    .clear,
                                    .clear,
                                    .clear,
                                    .clear,
                                    .black.opacity(0.92)], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        })
    }
}
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
