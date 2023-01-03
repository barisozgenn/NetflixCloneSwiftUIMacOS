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
            //HomeView()
             PlayerView()
                .environmentObject(HomeViewModel())
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
        .windowToolbarStyle(.unified)
        .windowResizability(.contentMinSize)
        .defaultSize(width: 1158, height: 672)
        
        
        Window("film", id: "content-expanded-window") {
            ContentExpandedView()
                .environmentObject(ContentExpandedViewModel())
                .preferredColorScheme(.dark)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification), perform: { _ in
                    hideToolbar()
                })
                .onAppear{hideToolbar()}
                .toolbarBackground(LinearGradient(
                    colors: [
                        Color(.black),
                        Color(.darkGray)
                    ],
                    startPoint: .top,
                    endPoint: .bottom))
                
        }
        .defaultPosition(.center)
        .defaultSize(width: 429, height: 514)
        
        
    }
    func hideToolbar(){
        NSApp.mainWindow?.standardWindowButton(.closeButton)?.isHidden = true
        NSApp.mainWindow?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        NSApp.mainWindow?.standardWindowButton(.zoomButton)?.isHidden = true
    }
}
