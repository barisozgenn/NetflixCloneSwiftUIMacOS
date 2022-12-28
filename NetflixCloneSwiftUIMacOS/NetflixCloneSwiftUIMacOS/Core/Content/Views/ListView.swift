//
//  ListView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 28.12.2022.
//

import SwiftUI

struct ListView: View {
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
                        ForEach(0...20, id: \.self) { item in
                            ContentCellView(canHover: true)
                                .position(x: CGFloat(item) * 218.0, y: 200)
                                .shadow(color: hoverItemIndex == item ? .black : .clear, radius: 4, x: 2, y: 2)
                                .zIndex(hoverItemIndex == item ? 7 : 1)
                                .onHover { hover in
                                    if hover {
                                        withAnimation(.spring()){
                                            hoverItemIndex = item
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
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
