//
//  ContentView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 17.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TransitionPlayerView()
        }
        .background(.yellow)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
