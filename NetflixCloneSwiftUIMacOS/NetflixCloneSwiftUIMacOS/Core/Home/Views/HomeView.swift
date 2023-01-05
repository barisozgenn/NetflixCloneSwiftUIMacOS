//
//  HomeView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 26.12.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel

    @State var selectedMenuName: String = "Home"
    @State var searchText: String = ""
    @State var islaunchScreenEnd: Bool = false
    @State var islaunchScreenRemove: Bool = false
    @State var hoverListId = "none"

    var body: some View {
        GeometryReader { proxy in
            NavigationStack{
                ZStack{
                    if islaunchScreenRemove{
                        ScrollView{
                            VStack{
                                headerVideoView
                                gradientFadeHeaderVideo
                                contentListsView
                                
                                Spacer()
                                Text("w:\(proxy.size.width) h:\(proxy.size.height)")
                                    .padding(50)
                            }
                        }
                        .frame(maxHeight: .infinity)
                    }
                    else{
                        launchVideoView
                    }
                }
                .frame(minWidth: 1158, maxWidth: 1158, minHeight: 672,maxHeight: .infinity)
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
extension HomeView {
    private var launchVideoView: some View{
        TransitionPlayerView(isVideoEnd: $islaunchScreenEnd)
            .onChange(of: islaunchScreenEnd) { newValue in
                withAnimation(.easeIn(duration: 2)){
                    islaunchScreenRemove = true
                }
            }
    }
    private var headerVideoView: some View{
        HeaderVideoView()
            .environmentObject(viewModel)
    }
    private var gradientFadeHeaderVideo: some View{
        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .center)
            .frame(maxWidth: .infinity,minHeight: 192, maxHeight: 192)
            .padding(.top, -200)
    }
    private var contentListsView: some View {
        ForEach(Array(viewModel.contentList.enumerated()), id: \.offset) {index, item in
            ListView(contents: item.contents, title: item.title)
                .padding(.top,index == 0 ? -100 : 0)
                .onHover { hover in
                    if hover {
                        withAnimation(.spring()){
                            hoverListId = item.title
                        }
                    }else {
                        hoverListId = "none"
                    }
                }
                .zIndex(hoverListId == item.title ? 7 : 0)
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
