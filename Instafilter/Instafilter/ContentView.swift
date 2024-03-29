//
//  ContentView.swift
//  Instafilter
//
//  Created by Noah Glaser on 8/3/22.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var radius = 0.5
    @State private var size = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var showingFilterSheet = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                        
                }.onTapGesture {
                    showingImagePicker = true
                }
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing()
                        }
                }.padding(.vertical)
                HStack {
                    Text("Size")
                    Slider(value: $size)
                        .onChange(of: size) { _ in applyProcessing()
                        }
                }.padding(.vertical)
                HStack {
                    Text("Radius")
                    Slider(value: $radius)
                        .onChange(of: radius) { _ in applyProcessing()
                        }
                }.padding(.vertical)
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    Spacer()
                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }.padding([.horizontal, .bottom])
                .navigationTitle("InstaFilter")
                .onChange(of: inputImage, perform: { _ in loadImage()
                })
                
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                    Button("Crystallize") { setFilter(CIFilter.crystallize())}
                    Button("Edges") { setFilter(CIFilter.edges())}
                    Button("Gaussian Blue") { setFilter(CIFilter.gaussianBlur())}
                    Button("CIBloom") { setFilter(CIFilter.bloom())}
                    Button("Comic Effect") { setFilter(CIFilter.comicEffect())}
                    Button("Twirl Distortion") { setFilter(CIFilter.twirlDistortion())}
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone())
                    }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask())
                        
                    }
                    Button("Vignette") { setFilter(CIFilter.vignette())}
                    Button("Cancel", role: .cancel) { }
                }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x:1000, y:1000), forKey: kCIInputCenterKey)
        }

        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radius * 1000, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(size * 30, forKey: kCIInputScaleKey)
        }
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func save() {
        guard let processedImage = processedImage else {
            return
        }

        let imageSaver = ImageSaver()
        imageSaver.successHanlder = {
            print("Success")
        }
        imageSaver.errorHandler = {
            print("Oop! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
