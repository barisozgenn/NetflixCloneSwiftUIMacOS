//
//  NetflixCloneSwiftUIMacOSApp.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 17.11.2022.
//

import SwiftUI

@main
struct NetflixCloneSwiftUIMacOSApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .frame(width: 992, height: 558)
                .toolbarBackground(
                    LinearGradient(
                        colors: [
                            Color(.init(red: 0.90, green: 0.04, blue: 0.08, alpha: 1.00)),
                            .clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom),
                    for: .windowToolbar)
                .toolbarBackground(.visible, for: .windowToolbar)
                .background(.black)
                .preferredColorScheme(.dark)
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 992, height: 558)
        .windowToolbarStyle(.unified)
    }
}
