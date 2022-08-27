//
//  PictureFormView.swift
//  RememberMe
//
//  Created by Noah Glaser on 8/25/22.
//

import SwiftUI

struct FormPictureView: View {
    
    @Binding var image: UIImage?
    @State var name = ""
    @ObservedObject var pictureStore: PictureStore
    @Environment(\.dismiss) private var dismiss
    let locationFetcher = LocationFetcher()

    var body: some View {
            
            Form {
                Section {
                    Text("Add Person").font(.largeTitle)
                }
                TextField("Name", text: $name)
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Save") {
                            if let image = image {
                                do {
                                    try pictureStore.addPicture(name: name, uiImage: image)
                                } catch {
                                    print("Failed to save", error.localizedDescription)
                                }
                            }
                            dismiss()
                        }.foregroundColor(.green)
                        Spacer()
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Dismiss", role: .cancel) {
                            dismiss()
                        }.foregroundColor(.red)
                        Spacer()
                    }
                }
            }
    }
}

