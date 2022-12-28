//
//  ListHeaderView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 28.12.2022.
//

import SwiftUI

struct ListHeaderView: View {
    @Binding var isListHover: Bool
    @State private var isHeaderHover: Bool = false
    var title: String = "List Title"
    var body: some View {
        HStack(alignment: .bottom, spacing: 0){
            Text(title)
                .foregroundColor(.white)
                .font(.title)
            
            Text("Explore All")
                .foregroundColor(.cyan)
                .font(.headline)
                .frame(width: isHeaderHover ? 70 : 0, height: 18)
                .scaleEffect(x: isHeaderHover ? 1 : 0)
                .opacity(isHeaderHover ? 1 : 0)
                .padding(.leading, isHeaderHover ? 7 : 0)
                .padding(.bottom, 1)
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(height: 12)
                .opacity(isHeaderHover || isListHover ? 1 : 0)
                .foregroundColor(.cyan)
                .padding(.leading, 7)
                .padding(.bottom, 4)
        }
        .fontWeight(.semibold)
        .padding(.horizontal)
        .onHover { hover in
            withAnimation(.spring()){
                isHeaderHover = hover
            }
        }
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView(isListHover: .constant(false))
    }
}
