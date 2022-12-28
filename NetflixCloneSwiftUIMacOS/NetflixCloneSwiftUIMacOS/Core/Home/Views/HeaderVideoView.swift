//
//  HeaderVideoView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 27.12.2022.
//

import SwiftUI
import AVKit
struct HeaderVideoView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var isFocused = true
    var body: some View {
        ZStack(alignment: .bottomLeading){
            videoPlayerView
            
            HStack{
                VStack(alignment: .leading,spacing: 0){
                    // type of content
                    HStack{
                        Image("img-netflix-logo-letter")
                            .resizable()
                            .scaledToFit()
                            .frame(height: isFocused ? 24 : 36)
                            .opacity(0.92)
                        Text("MOVIES")
                            .font(isFocused ? .headline : .title3)
                            .foregroundColor(Color(.lightGray).opacity(0.92))
                        
                    }
                    // content logo and description
                    VStack(alignment: .leading){
                        Image("avatar-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: isFocused ? 72 : 129)
                            .opacity(0.92)
                            .foregroundColor(.white)
                            .padding(.vertical, -14)
                        
                        
                        Text("Avatar takes us to the amazing world of Pandora, where a man embarks on an epic adventure, ultimately fighting to save both the people he loves and the place he now calls home.")
                            .font(.headline)
                            .foregroundColor(.white)
                            .opacity(isFocused ? 1 : 0)
                            .frame(height: isFocused ? 100 : 0)
                            .frame(width: 258)
                    }
                    // content buttons
                    HStack{
                        HStack{
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: isFocused ? 24 : 20)
                                .opacity(0.92)
                                .foregroundColor(.black)
                            Text("Play")
                                .font(isFocused ? .title2 : .title3)
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal)
                        .padding(.vertical,7)
                        .background(.white)
                        .cornerRadius(7)
                        HStack{
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: isFocused ? 24 : 20)
                                .opacity(0.92)
                                .foregroundColor(.white)
                            Text("More Info")
                                .font(isFocused ? .title2 : .title3)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        .padding(.vertical,7)
                        .background(.gray.opacity(0.7))
                        .cornerRadius(7)
                        .padding(.vertical, isFocused ? 20 : 0)
                    }
                }
                .padding(.horizontal)
                Spacer()
                HStack{
                    // volume
                    Image(systemName: "speaker.wave.3")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .opacity(0.92)
                        .padding(12)
                        .background(Circle().stroke(.white))
                    HStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 7, height: 40)
                        Text("7+")
                            .padding(.leading, 7)
                            .padding(.trailing, 92)
                            .font(.title2)
                    }
                    .background(.black.opacity(0.29))
                    .padding(.trailing, -29)
                }
                .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.bottom, 192)
            
        }
        .fontWeight(.semibold)
        .frame(width: 1158, height: 650)
        .foregroundColor(.white)
        .offset(y:-70)
        .onHover { hover in
            withAnimation(.spring()){
                isFocused = hover
            }
        }
    }
}
extension HeaderVideoView{
    private var videoPlayerView : some View {
        AVPlayerRepresented(videoPlayer: viewModel.headerVideoPlayer)
            .frame(maxWidth: .infinity)
            .disabled(true)
            .background(.purple)
    }
}
struct HeaderVideoView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderVideoView()
            .environmentObject(HomeViewModel())
    }
}
