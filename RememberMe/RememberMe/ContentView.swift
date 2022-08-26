//
//  ContentView.swift
//  RememberMe
//
//  Created by Noah Glaser on 8/22/22.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    
    case imagePicker, add
    
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    
    @State var showPhotoPicker = false
    @State var uiImage: UIImage?
    @State var activeSheet: ActiveSheet?
    @StateObject var pictureStore = PictureStore()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(pictureStore.pictures.sorted(), id: \.id) { picture in
                    if let image =  UIImage(contentsOfFile:picture.url.path) {
                        VStack {
                            Text(picture.name)
                                .font(.title)
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                            HStack {
                                NavigationLink {
                                    PictureView(picture: picture, image: image)
                                } label: {
                                    Text("View")
                                }
                                Button("Delete") {
                                    do {
                                        try pictureStore.delete(picture: picture)
                                    } catch {
                                        print(error.localizedDescription, "deleting picture")
                                    }
                                }
                            }
                        }.padding()
                    }
                }
            }.navigationTitle("Remember Me")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            activeSheet = .imagePicker
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }.sheet(item: $activeSheet) { item in
                    switch item {
                    case .add:
                        FormPictureView(image: $uiImage, pictureStore: pictureStore)
                    case .imagePicker:
                        ImagePicker(image: $uiImage, activeSheet: $activeSheet)
                    }
                }
        }
    }
    
    func addPicture(uiImage: UIImage) {
        print("SAVE IMAGE")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
