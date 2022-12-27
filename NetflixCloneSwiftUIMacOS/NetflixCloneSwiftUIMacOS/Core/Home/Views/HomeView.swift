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
    @State var islaunchScreenRemove: Bool = false
    var body: some View {
        GeometryReader { proxy in
            NavigationStack{
                ZStack{
                    
                    if islaunchScreenRemove{
                        HeaderVideoView()
                    }
                    else{
                        TransitionPlayerView(isVideoEnd: $islaunchScreenEnd)
                            .onChange(of: islaunchScreenEnd) { newValue in
                                withAnimation(.easeIn(duration: 2)){
                                    islaunchScreenRemove = true
                                }
                            }
                    }
                }
                .frame(minWidth: 1158, maxWidth: .infinity, minHeight: 729,maxHeight: .infinity)
                .background(.black)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        HStack{
                            Spacer()
                            HomeToolBarView( selectedMenuName: $selectedMenuName)
                                .opacity(islaunchScreenRemove ? 1 : 0)
                        }
                        
                    }
                        ToolbarItem(placement: .automatic) {
                            HStack{
                                Spacer()
                                CustomToolBarTrailingView(selectedMenuName: $selectedMenuName, searchText: $searchText)
                                    .opacity(islaunchScreenRemove ? 1 : 0)
                            }
                            .frame(minWidth: proxy.size.width - 666)
                        }
                        
                }
            }
        }
       
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
