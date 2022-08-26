//
//  PictureState.swift
//  RememberMe
//
//  Created by Noah Glaser on 8/22/22.
//

import Foundation
import UIKit

struct Picture: Codable, Identifiable, Comparable {
    
    
    var id = UUID()
    var name: String
    var url: URL
    
    static func < (lhs: Picture, rhs: Picture) -> Bool {
        lhs.name < rhs.name
    }
}

class PictureStore: ObservableObject {
    
    @Published var pictures: [Picture] = []
    init() {
        if let pics: [Picture] =  try? FileManager.read(fileName: "people.json") {
            pictures = pics
        }
    }
    
    
    func addPicture(name: String, uiImage: UIImage) throws {
        let id = UUID()
        let url = try savePicture(image: uiImage, id: id)
        let newPicture = Picture(id: id, name: name, url: url)
        pictures.append(newPicture)
        FileManager.write(objects: pictures, fileName: "people.json")
    }
    
    func savePicture(image: UIImage, id: UUID) throws -> URL {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try jpegData.write(to: FileManager.fileURL(name: id.uuidString), options: [.atomic, .completeFileProtection])
        }
        
        return FileManager.fileURL(name: id.uuidString)
    }
    
    func delete(picture: Picture) throws {
        pictures = pictures.filter{ $0.id != picture.id }
        try FileManager.delete(url: picture.url)
        FileManager.write(objects: pictures, fileName: "people.json")
    }
}
