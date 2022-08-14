//
//  FileManagerExtension.swift
//  BucketList
//
//  Created by Noah Glaser on 8/10/22.
//

import Foundation


extension FileManager {
    
    static func write(text: String, fileName: String) -> Bool {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func read(fileName: String) throws -> String {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)

        return try String(contentsOf: url)
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

            // just send back the first one, which ought to be the only one
            return paths[0]
        
    }
}
