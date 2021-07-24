//
//  PersistenceController.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import Foundation

class PersistenceManager {
    
    public static let shared = PersistenceManager()
    
    private init() {
        
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
}
