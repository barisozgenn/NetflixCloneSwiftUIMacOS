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
            ContentView()
                .toolbarBackground(
                    LinearGradient(
                        colors: [
                            .red,
                            Color(.init(red: 0.5, green: 0, blue: 0, alpha: 1))
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
       .windowToolbarStyle(.expanded)
    }
}
