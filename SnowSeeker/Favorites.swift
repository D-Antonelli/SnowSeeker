//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Derya Antonelli on 24/04/2023.
//

import Foundation


class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out data
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
}
