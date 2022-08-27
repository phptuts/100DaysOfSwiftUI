//
//  PictureView.swift
//  RememberMe
//
//  Created by Noah Glaser on 8/25/22.
//

import SwiftUI
import MapKit

struct PictureView: View {
    
    let picture: Picture
    let image: UIImage

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            Spacer()
            Map(coordinateRegion: .constant(picture.region), annotationItems: [picture]) { pic in
                MapPin(coordinate: pic.region.center)
            }
            Spacer()
            Spacer()
            Spacer()
        }
        .padding()
        .navigationTitle(picture.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


