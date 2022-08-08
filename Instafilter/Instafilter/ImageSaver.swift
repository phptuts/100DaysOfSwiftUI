//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Noah Glaser on 8/6/22.
//

import UIKit

class ImageSaver: NSObject {
    
    var successHanlder: (() -> Void)?
    
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc  func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved Finished")
        
        if let error = error {
            errorHandler?(error)
        } else {
            successHanlder?()
        }
    }
}

