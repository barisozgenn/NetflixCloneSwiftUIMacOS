//
//  ListView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 28.12.2022.
//

import SwiftUI
import RealmSwift
struct ListView: View {
    let contents: [ContentRealmModel]
    
    var title: String = "List View Title"
    @State private var isListHover = false
    @State private var hoverItemIndex = -1
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                ListHeaderView(isListHover: $isListHover, title: title)
                    .padding(.horizontal)
                    .zIndex(2)
                
                ScrollView(.horizontal){
                    ZStack{
                        ForEach(contents, id: \._id) {item in
                            let index = contents.firstIndex(of: item)!
                            ContentCellView(canHover: true, content: item)
                                .position(x: CGFloat(index) * 218.0, y: 200)
                                .shadow(color: hoverItemIndex == index ? .black : .clear, radius: 4, x: 2, y: 2)
                                .zIndex(hoverItemIndex == index ? 7 : 1)
                                .onHover { hover in
                                    if hover {
                                        withAnimation(.spring()){
                                            hoverItemIndex = index
                                        }
                                    }else {
                                        withAnimation(.spring()){
                                            hoverItemIndex = -1
                                        }
                                    }
                                }
                        }
                    }
                }
                .frame(height: 400)
                .padding(.top, -129)
                .scrollIndicators(.hidden)
                .onHover { hover in
                    withAnimation(.spring()){
                        isListHover = hover
                    }
                }
            }
            .padding(.top)
        }
        .padding(.top, -129)
        .onAppear{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moreLikeContents"),
                                            object: contents.sorted(by: {$0.episodes.first!.episodeDescription.count > $1.episodes.first!.episodeDescription.count}).prefix(9).shuffled())
        }
    }
}
/*
 struct ListView_Previews: PreviewProvider {
 static var previews: some View {
 ListView()
 }
 }*/
