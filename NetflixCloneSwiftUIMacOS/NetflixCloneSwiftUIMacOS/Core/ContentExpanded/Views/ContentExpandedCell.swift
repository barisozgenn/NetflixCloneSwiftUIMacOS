//
//  ContentExpandedCell.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 3.01.2023.
//

import SwiftUI

struct ContentExpandedCell: View {
    @State var isHover = false
    var body: some View {
        VStack{
            imageView
            contentDescription
            Spacer()
        }
        .frame(height: 358)
        .background(Color(.darkGray))
        .cornerRadius(4)
    }
}
extension ContentExpandedCell {
    private var imageView:some View{
        ZStack{
            // content image and video
            Image(systemName: "photo.artframe")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
                .cornerRadius(4)
            
            // duration
            VStack{
                HStack{
                    Spacer()
                    Text("1h 29m")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .shadow(color: .black, radius: 3, x:1, y:1)
                        .padding()
                }
                Spacer()
            }
            
            // play button
            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 14)
                .opacity(isHover ? 1: 0)
                .padding(12)
                .background {
                    Circle()
                        .strokeBorder(.white, lineWidth: 1.29)
                        .background(Circle().fill(.black.opacity(0.29)))
                }
        }
        .frame(height: 129)
        .onHover { hover in
            withAnimation(.spring()){isHover=hover}
        }
    }
    private var contentDescription:some View{
        VStack{
            // top
            HStack{
                VStack(alignment: .leading){
                    Text("92% Match")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .font(.title3)
                    HStack{
                        Text("7+")
                            .padding(2)
                            .padding(.horizontal)
                            .background(Rectangle().stroke(Color(.lightGray)))
                        Text("2023")
                            .padding(2)
                    }
                }
                Spacer()
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .opacity(0.92)
                    .padding(12)
                    .background {
                        Circle()
                            .strokeBorder(.white, lineWidth: 1.29)
                            .background(Circle().fill(.black.opacity(0.29)))
                    }
            }
            // bottom
            Text("Avatar takes us to the amazing world of Pandora, where a man embarks on an epic adventure, ultimately fighting to save both the people he loves and the place he now calls home.")
                .lineLimit(7)
                .padding(.top)
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}
struct ContentExpandedCell_Previews: PreviewProvider {
    static var previews: some View {
        ContentExpandedCell()
    }
}
