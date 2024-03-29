//
//  MeView.swift
//  HotProspects
//
//  Created by Noah Glaser on 9/15/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreImage
import UserNotifications


struct MeView: View {
    
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                        
                    }
            }.navigationTitle("Your Code")
                .onAppear(perform: updateCode)
                .onChange(of: name, perform: { _ in updateCode() } )
                .onChange(of: emailAddress, perform: { _ in updateCode() })
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circl") ?? UIImage()
    }
    
    
}


struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
