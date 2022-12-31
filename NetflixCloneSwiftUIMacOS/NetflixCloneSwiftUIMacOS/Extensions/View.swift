//
//  View.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 31.12.2022.
//

import SwiftUI

extension View {
    func withPlayerButtonModifier(frameHeight: CGFloat = 25) -> some View {
        modifier(PlayerButtonViewModifier(frameHeight: frameHeight))
    }
}

