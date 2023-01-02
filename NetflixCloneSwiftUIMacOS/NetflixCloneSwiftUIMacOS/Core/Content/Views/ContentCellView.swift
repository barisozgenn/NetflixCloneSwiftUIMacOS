//
//  ContentCellView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 28.12.2022.
//

import SwiftUI

struct ContentCellView: View {
    @State var canHover = false
    @State var isHover = false
    var body: some View {
        ZStack{
            VStack{
                // content image and video
                Image(systemName: "person.fill")
                    .frame(width: isHover ? 315 : 215, height: isHover ? 190 : 125)
                    .background(.red)
                    .cornerRadius(4)
                if isHover {
                    VStack(alignment: .leading){
                        // content control buttons
                        HStack{
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .padding(12)
                                .foregroundColor(.black)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Circle().stroke(Color(.lightGray)))
                            Image(systemName: "hand.thumbsup")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Circle().stroke(Color(.lightGray)))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 12)
                                .padding(16)
                                .foregroundColor(.white)
                                .background(Circle().stroke(Color(.lightGray)))
                        }
                        // content description
                        HStack{
                            Text("92% Match")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                                .font(.title3)
                            Text("7+")
                                .padding(2)
                                .padding(.horizontal)
                                .background(Rectangle().stroke(Color(.lightGray)))
                            Text("3 Episodes")
                                .padding(2)
                            Text("HD")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(2)
                                .padding(.horizontal,6)
                                .background(Rectangle().stroke(Color(.lightGray)))
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        // content categories
                        Text("Category • Category • Category")
                            .font(.title3)
                            .fontWeight(.regular)
                    }
                    .padding()
                  
                }
            }
        }
        .frame(width: isHover ? 315 : 215)
        .background(.black)
        .cornerRadius(4)
        .onHover { hover in
            if canHover {
                withAnimation(.spring()){isHover=hover}
            }
        }
    }
}

struct ContentCellView_Previews: PreviewProvider {
    static var previews: some View {
        ContentCellView()
    }
}
