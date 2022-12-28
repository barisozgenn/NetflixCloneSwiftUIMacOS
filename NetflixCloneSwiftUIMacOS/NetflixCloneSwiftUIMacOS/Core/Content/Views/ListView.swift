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
    var body: some View {
        VStack(alignment: .leading){
            ListHeaderView(isListHover: $isListHover, title: title)
                .padding(.horizontal)
            ScrollView(.horizontal){
                HStack{
                    ForEach(0...20, id: \.self) { item in
                        ContentCellView()
                    }
                }
            }
            .scrollIndicators(.hidden)
            .onHover { hover in
                withAnimation(.spring()){
                    isListHover = hover
                }
            }
        }
        .padding(.top)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
