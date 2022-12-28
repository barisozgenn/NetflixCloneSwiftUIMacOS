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
    @EnvironmentObject private var viewModel: HomeViewModel
    var body: some View {
        GeometryReader { proxy in
            NavigationStack{
                ZStack{
                    if islaunchScreenRemove{
                        ScrollView{
                            VStack{
                                HeaderVideoView()
                                    .environmentObject(viewModel)
                                
                                ListView(title: "Documentaries")
                                
                                    .background {
                                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .center)
                                    }
                                    .padding(.top, -229)
                                Spacer()
                                Text("w:\(proxy.size.width) h:\(proxy.size.height)")
                                    .padding(50)
                            }
                        }
                        .frame(maxHeight: .infinity)
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
                .frame(minWidth: 1158, maxWidth: .infinity, minHeight: 672,maxHeight: .infinity)
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
            .environmentObject(HomeViewModel())
    }
}
