//
//  PersistenceController.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import Foundation
import UIKit

class PersistenceManager {
    
    public static let shared = PersistenceManager()
    
    private init() {
        
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func saveImage(_ image: UIImage?, to path: URL) {
        if let jpegData = image?.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: path)
        }
    }
    
}
