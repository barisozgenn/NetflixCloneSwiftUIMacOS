//
//  ContentExpandedView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 2.01.2023.
//

import SwiftUI

struct ContentExpandedView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var viewModel: ContentExpandedViewModel
    @State private var isFocused = true
    @State private var isHeaderVideoSelected = false
    
    var body: some View {
        ZStack(alignment:.top){
            ZStack(alignment: .bottomLeading){
                videoPlayerView
                
                HStack{
                    VStack(alignment: .leading,spacing: 0){
                      
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
                            .onTapGesture {
                                withAnimation(.spring()){
                                    isHeaderVideoSelected.toggle()
                                }
                            }
                            .sheet(isPresented: $isHeaderVideoSelected) {
                                PlayerView()
                                    .presentationDragIndicator(.visible)
                            }
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .opacity(0.92)
                                .padding(12)
                                .background(Circle().stroke(.white))
                            Image(systemName: "hand.thumbsup")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .opacity(0.92)
                                .padding(12)
                                .background(Circle().stroke(.white))
                            Spacer()
                            // volume
                            Image(systemName: "speaker.wave.3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .opacity(0.92)
                                .padding(12)
                                .background(Circle().stroke(.white))
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 29)
            }
            closeMarkView
            VStack{
                Spacer()
            }
        }
        .background(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
extension ContentExpandedView{
    private var videoPlayerView : some View {
        AVPlayerRepresented(videoPlayer: viewModel.videoPlayer)
            .frame(maxWidth: .infinity)
            .disabled(true)
            .background(.purple)
    }
    private var closeMarkView: some View{
        HStack{
            Spacer()
            Image(systemName: "x.circle.fill")
                .resizable()
                .foregroundColor(Color(.darkGray))
                .background(.white)
                .clipShape(Circle())
                .withPlayerButtonModifier(frameHeight: 27)
                .onTapGesture { withAnimation(.spring()){dismiss()}}
        }
        .padding()
    }
}

struct ContentExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentExpandedView()
            .environmentObject(ContentExpandedViewModel())
    }
}
