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
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.black)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack{
                        Spacer()
                        CustomToolBarTrailingView(selectedMenuName: $selectedMenuName, searchText: $searchText)
                    }
                    
                }
            }
        }
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
