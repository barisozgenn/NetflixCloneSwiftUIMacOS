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
    
    let data = (1...100).map { "Item \($0)" }

        let columns = [
            GridItem(),
            GridItem(),
            GridItem()
        ]
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack(alignment: .bottom){
                    videoPlayerView
                    
                    contentButtonsView
                    
                    closeMarkView
                }
                contentDetailView
                listView
                Spacer()
            }
        }
        .background(.black)
        .frame(width: 629)
    }
}
extension ContentExpandedView{
    private var videoPlayerView : some View {
        AVPlayerRepresented(videoPlayer: viewModel.videoPlayer)
            .frame(maxWidth: viewModel.videoFrame.width, maxHeight: viewModel.videoFrame.height)
            .disabled(true)
            .background(.purple)
    }
    private var closeMarkView: some View{
        VStack{
            HStack{
                Spacer()
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .foregroundColor(Color(.darkGray))
                    .background(.white)
                    .clipShape(Circle())
                    .withPlayerButtonModifier(frameHeight: 27)
                    .onTapGesture { withAnimation(.spring()){
                        //dismiss()
                        NSApplication.shared.windows.first(where: {$0.identifier?.rawValue ?? "" == "content-expanded-window"})?.performClose(nil)
                    }}
            }
            .padding()
            Spacer()
        }
    }
    private var contentDetailView:some View{
        // content description
        HStack{
            VStack(alignment: .leading){
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
                Text("Avatar takes us to the amazing world of Pandora, where a man embarks on an epic adventure, ultimately fighting to save both the people he loves and the place he now calls home.")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading){
                // cast
                HStack(alignment: .top){
                    Text("Cast:")
                        .foregroundColor(.gray)
                    Text("artist, artis, artis")
                }
                // genres
                HStack(alignment: .top){
                    Text("Genres:")
                        .foregroundColor(.gray)
                    Text("Genres, Genres & Genres")
                }
                // this movie is
                HStack(alignment: .top){
                    Text("This movie is:")
                        .foregroundColor(.gray)
                    Text("This movie is bla la")
                }
            }
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
    }
    private var contentButtonsView: some View{
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
                            //dismiss()
                            NSApplication.shared.windows.first(where: {$0.identifier?.rawValue ?? "" == "content-expanded-window"})?.performClose(nil)
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
                        .background {
                            Circle()
                                .strokeBorder(.white, lineWidth: 1.29)
                                .background(Circle().fill(.black.opacity(0.29)))
                        }
                    Image(systemName: "hand.thumbsup")
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
                    Spacer()
                    // volume
                    Image(systemName: "speaker.wave.3")
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
            }
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
        .padding(.bottom, 29)
    }
    private var listView: some View{
        VStack(alignment:.leading){
            Text("More Like This")
                .foregroundColor(.white)
                .font(.title)
                .padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(data, id: \.self) { item in
                                ContentExpandedCell()
                            }
                        }
                        .padding(.horizontal)
        }
    }
}

struct ContentExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentExpandedView()
            .environmentObject(ContentExpandedViewModel())
    }
}
