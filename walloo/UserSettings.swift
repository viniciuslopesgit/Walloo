//
//  UserSettings.swift
//  iForget
//
//  Created by Vinícius Lopes on 24/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    
    @Published var useTouch: Bool {
        didSet {
            UserDefaults.standard.set(useTouch, forKey: "useTouch")
        }
    }
    @Published var isAutoLock: Bool {
        didSet {
            UserDefaults.standard.set(isAutoLock, forKey: "isAutoLock")
        }
    }
    @Published var isNotify: Bool {
        didSet {
            UserDefaults.standard.set(isNotify, forKey: "isNotify")
        }
    }
    @Published var isSync: Bool {
        didSet {
            UserDefaults.standard.set(isSync, forKey: "isSync")
        }
    }
    @Published var proBuy: Bool {
        didSet {
            UserDefaults.standard.set(proBuy, forKey: "proBuy")
        }
    }
    @Published var isFirst: Bool {
        didSet {
            UserDefaults.standard.set(isFirst, forKey: "isFirst")
        }
    }
    //AVISOS
    
    @Published var workOffline: Bool {
        didSet {
            UserDefaults.standard.set(workOffline, forKey: "workOffline")
        }
    }
    
    @Published var passportInCards: Bool {
        didSet {
            UserDefaults.standard.set(passportInCards, forKey: "passportInCards")
        }
    }
    
    //
    
    init() {
        self.useTouch = UserDefaults.standard.object(forKey: "useTouch") as? Bool ?? true
        
        self.isNotify = UserDefaults.standard.object(forKey: "isNotify") as? Bool ?? true
        
        self.isAutoLock = UserDefaults.standard.object(forKey: "isAutoLock") as? Bool ?? true
        
        self.isSync = UserDefaults.standard.object(forKey: "isSync") as? Bool ?? true
        
        self.proBuy = UserDefaults.standard.object(forKey: "proBuy") as? Bool ?? false
        
        self.isFirst = UserDefaults.standard.object(forKey: "isFirst") as? Bool ?? true
        
        self.workOffline = UserDefaults.standard.object(forKey: "workOffline") as? Bool ?? true
        
        self.passportInCards = UserDefaults.standard.object(forKey: "passportInCards") as? Bool ?? true
    }
    
    
}
