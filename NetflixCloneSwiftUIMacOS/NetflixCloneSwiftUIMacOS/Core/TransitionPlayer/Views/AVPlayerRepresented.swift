//
//  AVPlayerRepresented.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 26.12.2022.
//
import SwiftUI
import AVKit

struct AVPlayerRepresented : NSViewRepresentable {
    
    var videoPlayer : AVPlayer
    
    func makeNSView(context: Context) -> AVPlayerView {
        let view = AVPlayerView()
        view.controlsStyle = .none
        view.player = videoPlayer
        return view
    }
    
    func updateNSView(_ nsView: AVPlayerView, context: Context) {
      
    }
    
    
}
