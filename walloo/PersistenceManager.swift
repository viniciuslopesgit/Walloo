//
//  PersistenceManager.swift
//  iForget
//
//  Created by Vinícius Lopes on 20/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    enum Keys {
        static let launches = "Launches"
    }
    
    static var shared = PersistenceManager()
    private var defaults = UserDefaults.standard
    
    func fetchLauches() -> Int {
        return defaults.integer(forKey: Keys.launches)
    }
    
    func shouldRequestReview() -> Bool {
        var launches = fetchLauches()
        launches += 1
        defaults.set(launches, forKey: Keys.launches)
        if launches % 30 == 0 { return true }
        return false
    }
}
