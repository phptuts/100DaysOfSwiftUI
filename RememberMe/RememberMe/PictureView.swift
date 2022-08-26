//
//  PictureView.swift
//  RememberMe
//
//  Created by Noah Glaser on 8/25/22.
//

import SwiftUI

struct PictureView: View {
    
    let picture: Picture
    let image: UIImage

    var body: some View {
        VStack {
            Text(picture.name).font(.largeTitle)
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            Spacer()
        }.padding()
    }
}


