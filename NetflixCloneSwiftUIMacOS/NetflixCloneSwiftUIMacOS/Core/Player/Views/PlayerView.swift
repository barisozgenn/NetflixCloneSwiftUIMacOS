//
//  PlayerView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 30.12.2022.
//

import SwiftUI

struct PlayerView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = PlayerViewModel()
    @State private var isControlPanelVisible = false
    @State private var isFullScreen = false
    @State private var isVolumeHover = false
    @State private var isDissmiss = false
    
    var body: some View {
        ZStack{
            videoPlayerView
            controlPanelView
        }
        .frame(minWidth: viewModel.videoFrame.width,
               idealWidth: viewModel.videoFrame.width,
               maxWidth: viewModel.videoFrame.width,
               minHeight: viewModel.videoFrame.height,
               idealHeight: viewModel.videoFrame.height,
               maxHeight: viewModel.videoFrame.height)
        .scaleEffect(isDissmiss ? 0 : 1)
        .onTapGesture{withAnimation(.spring()){isControlPanelVisible.toggle()}}
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
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification), perform: { _ in
                NSApp.mainWindow?.standardWindowButton(.closeButton)?.isHidden = true
                NSApp.mainWindow?.standardWindowButton(.miniaturizeButton)?.isHidden = true
                NSApp.mainWindow?.standardWindowButton(.zoomButton)?.isHidden = true
                
            })
    }
    private var controlPanelView: some View {
        VStack(spacing:20){
            HStack{
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .onTapGesture {
                        viewModel.videoPlayStop()
                        withAnimation(.spring()){isDissmiss.toggle()}
                        withAnimation(.easeOut(duration: 3).delay(3)){dismiss()}
                    }
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
                    .foregroundColor(.red)
                
                Text("\(viewModel.videoDuration)")
                    .font(.headline)
            }
            .opacity(viewModel.videoCurrentTime < 1 || isVolumeHover ? 0.07 : 1)
            HStack{
                HStack(spacing:29){
                    Image(systemName: viewModel.videIsPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .withPlayerButtonModifier(frameHeight: 27)
                        .onTapGesture { viewModel.videoPlayStop() }
                    Image(systemName: "gobackward.10")
                        .resizable()
                        .withPlayerButtonModifier(frameHeight: 29)
                        .onTapGesture { viewModel.videoChangeTime(isForward: false) }
                    Image(systemName: "goforward.10")
                        .resizable()
                        .withPlayerButtonModifier(frameHeight: 29)
                        .onTapGesture { viewModel.videoChangeTime() }
                    Image(systemName: viewModel.videoVolume > 0.8  ? "speaker.wave.3.fill" :
                            viewModel.videoVolume > 0.5  ? "speaker.wave.2.fill" :
                            viewModel.videoVolume > 0.1  ? "speaker.wave.1.fill" : "speaker.slash.fill")
                    .resizable()
                    .withPlayerButtonModifier()
                    .onTapGesture { withAnimation(.spring()){isVolumeHover.toggle()} }
                    VStack{
                        Slider(value: $viewModel.videoVolume, in: 0...1)
                            .tint(.red)
                            .frame(width: 129, height: 40)
                            .padding(4)
                            .background(Color(.darkGray))
                            .rotationEffect(.degrees(-90.0))
                            .onChange(of: viewModel.videoVolume) { _ in
                                withAnimation(.spring()){viewModel.setVideoVolume()} }
                    }
                    .padding(.leading, -114)
                    .padding(.top, -129)
                    .opacity(isVolumeHover ? 1 : 0)
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
