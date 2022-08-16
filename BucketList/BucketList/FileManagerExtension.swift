//
//  FileManagerExtension.swift
//  BucketList
//
//  Created by Noah Glaser on 8/10/22.
//

import Foundation


extension FileManager {
    
    static func write<T: Codable>(objects: T, fileName: String) -> Bool {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            let data = try JSONEncoder().encode(objects)
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
        
        return false
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
}
