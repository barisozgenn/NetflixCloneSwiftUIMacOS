//
//  ContentCellView.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 28.12.2022.
//

import SwiftUI

struct ContentCellView: View {
    var body: some View {
        ZStack{
            Text("Item")
        }
        .frame(width: 215, height: 125)
        .background(.gray)
        .cornerRadius(4)
    }
}

struct ContentCellView_Previews: PreviewProvider {
    static var previews: some View {
        ContentCellView()
    }
}
