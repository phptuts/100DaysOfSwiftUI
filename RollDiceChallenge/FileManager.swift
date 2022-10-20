//
//  FileManager.swift
//  RollDiceChallenge
//
//  Created by Noah Glaser on 10/19/22.
//

import Foundation

//
//  FileManager.swift
//  RememberMe
//
//  Created by Noah Glaser on 8/22/22.
//
import Foundation

extension FileManager {
    
    static func write<T: Codable>(objects: T, fileName: String) throws  {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)

        let data = try JSONEncoder().encode(objects)
        try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
    }
    
    static func read<T: Codable>(fileName: String) throws -> T {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)

        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    static func delete(url: URL) throws {
        try FileManager.default.removeItem(at: url)
    }
    
    static func fileURL(name: String) -> URL {
        getDocumentsDirectory().appendingPathComponent(name)
    }
}
