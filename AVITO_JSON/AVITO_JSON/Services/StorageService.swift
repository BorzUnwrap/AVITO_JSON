//
//  StorageService.swift
//  AVITO_JSON
//
//  Created by admin on 09.09.2021.
//  Copyright © 2021 ZanLabEngine. All rights reserved.
//

import Foundation

class StorageService {
    
    static let shared = StorageService()
    
    private var plistURL: URL? {
      let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documents?.appendingPathComponent("savedData.plist")
    }

    func load() -> Company? {
      let decoder = PropertyListDecoder()

      guard let url = plistURL, let data = try? Data.init(contentsOf: url),
        let preferences = try? decoder.decode(Company.self, from: data)
        else { return nil }

      return preferences
    }
    
    func fileModificationDate() -> Date? {
        guard let url =  plistURL else { return nil }
        let attr = try? FileManager.default.attributesOfItem(atPath: url.path)
        return attr?[FileAttributeKey.modificationDate] as? Date
    }
    
    func write(data: Company) {
        let encoder = PropertyListEncoder()
        let fileManager = FileManager.default
        
        if let url = plistURL, let data = try? encoder.encode(data) {
            if fileManager.fileExists(atPath: url.path) {
                try? data.write(to: url, options: .atomic)
            } else {
                fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            }
        }
    }
}
