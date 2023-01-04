//
//  NetflixCloneSwiftUIMacOSApp.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 17.11.2022.
//

import SwiftUI
import RealmSwift

@main
struct NetflixCloneSwiftUIMacOSApp: SwiftUI.App {
    @NSApplicationDelegateAdaptor(CustomAppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let _ = print("DEBUG: Realm Path: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())")

            HomeView()
            // PlayerView()
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
        
        
        Window("", id: "content-expanded-window") {
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
        .defaultSize(width: 429, height: 592)
        
        
    }
    func hideToolbar(){
        NSApp.mainWindow?.standardWindowButton(.closeButton)?.isHidden = true
        NSApp.mainWindow?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        NSApp.mainWindow?.standardWindowButton(.zoomButton)?.isHidden = true
    }
}
class CustomAppDelegate: NSObject, NSApplicationDelegate {
    

    func applicationDidFinishLaunching(_ notify: Notification)  {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
}
