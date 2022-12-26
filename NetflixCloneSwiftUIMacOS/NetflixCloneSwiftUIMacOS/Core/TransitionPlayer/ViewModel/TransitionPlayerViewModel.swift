//
//  TransitionPlayerViewModel.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 26.12.2022.
//

import AVKit
import Combine

class TransitionPlayerViewModel: ObservableObject {
    @Published var isVideoEnd = false
    
    let videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "netflix-intro-for-launch", withExtension: "mp4")!)
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
            .sink { [weak self](_) in
                self?.isVideoEnd = true
            }.store(in: &cancellables)
    }
}
