//
//  HomeView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 26.12.2022.
//

import SwiftUI

struct HomeView: View {
    @State var selectedMenuName: String = "Home"
    @State var searchText: String = ""
    @State var islaunchScreenEnd: Bool = false

    var body: some View {
        NavigationStack{
            ZStack{
                
                TransitionPlayerView(isVideoEnd: $islaunchScreenEnd)
                HomeToolBarView.CustomToolBarTrailingView(selectedMenuName: $selectedMenuName, searchText: $searchText)
            }
        }
        .background(.black)
        .toolbar {
            HomeToolBarView( selectedMenuName: $selectedMenuName)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}