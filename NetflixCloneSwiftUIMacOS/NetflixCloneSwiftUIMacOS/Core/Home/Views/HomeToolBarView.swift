//
//  HomeToolBarView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 26.12.2022.
//

import SwiftUI

struct HomeToolBarView: View {
    @Binding var selectedMenuName: String
    @State private var foregroundColor : Color = .white
    var body: some View {
            HStack{
                Image("img-netflix-logo-word")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 18)
                    .tint(.white)
                    .shadow(color: .black.opacity(0.29), radius: 2,x: 2,y: 1)
                

                CustomToolBarItem(menuName: "Home", selectedMenuName: $selectedMenuName)
                CustomToolBarItem(menuName: "TV Shows", selectedMenuName: $selectedMenuName)
                CustomToolBarItem(menuName: "Movies", selectedMenuName: $selectedMenuName)
                CustomToolBarItem(menuName: "New & Popular", selectedMenuName: $selectedMenuName)
                CustomToolBarItem(menuName: "My List", selectedMenuName: $selectedMenuName)
             
            }
    }
}
extension HomeToolBarView {
    struct CustomToolBarItem: View {
        let menuName: String
        @Binding var selectedMenuName: String
        @State private var foregroundColor : Color = .white
        var body: some View {
            Text(menuName)
                .foregroundColor(foregroundColor)
                .fontWeight(selectedMenuName == menuName ? .bold : .regular)
                .onHover { hover in
                    withAnimation(.spring()){
                        foregroundColor = hover ? Color(.lightGray) : .white
                    }
                }
                .onTapGesture {
                    selectedMenuName = menuName
                }
                .padding(.horizontal)
        }
    }
}
struct CustomToolBarTrailingView: View {
    @Binding var selectedMenuName: String
    @State private var foregroundColor : Color = .white
    @State private var isSearchActive = false
    @Binding var searchText: String

    var body: some View {
        HStack{
            Spacer()
            searchView
            HomeToolBarView.CustomToolBarItem(menuName: "Kids", selectedMenuName: $selectedMenuName)
            Image(systemName: "bell")
                .resizable()
                .scaledToFit()
                .frame(height: 18)
                .tint(.white)
            HStack{
                Image("default-profile-baris")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .background(.blue)
                    .cornerRadius(4)
                    .padding(.leading,14)
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .tint(.white)
                    .padding(.trailing,7)
            }
        }
    }
    private var searchView: some View{
        HStack{
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(height: 18)
                .tint(.white)
                .onTapGesture {
                    withAnimation(.spring()){
                        isSearchActive.toggle()
                    }
                }
            TextField("Search...", text: $searchText)
                .frame(width: isSearchActive ? 107 : 0)
                .scaleEffect(x: isSearchActive ? 1 : 0)
                .textFieldStyle(.plain)
                .foregroundColor(.white)
        }
        .padding(.all, 4)
        .overlay {
            if isSearchActive {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.white, lineWidth: 1)
            }
        }
    }
}

struct HomeToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeToolBarView(selectedMenuName: .constant("Menu"))
    }
}
