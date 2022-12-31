//
//  PlayerButtonViewModifier.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 31.12.2022.
//

import SwiftUI

struct PlayerButtonViewModifier: ViewModifier {
    @State var frameHeight = 25.0
    @State private var isHover = false
    func body(content: Content) -> some View {
        content
            .onHover { hover in
                withAnimation(.spring()){
                    isHover = hover
                }
            }
            .scaledToFit()
            .frame(height: frameHeight)
            .scaleEffect(isHover ? 1.4 : 1)
            .brightness(isHover ? 0.07 : 0)
    }
}
