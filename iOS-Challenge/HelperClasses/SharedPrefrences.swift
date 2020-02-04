//
//  SharedPrefrences.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation

enum PrefrencesKeys : String{
    
    case gitToken = "Token"
    
}


class SharedPrefrences{
    
    private let defaults = UserDefaults.standard
    
    func get(key:PrefrencesKeys) -> Any?
    {
        return defaults.object(forKey: key.rawValue)
    }
    
    func set(key:PrefrencesKeys,value:Any)
    {
        return defaults.set(value, forKey: key.rawValue)
    }
    
    func remove(key: PrefrencesKeys)
    {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func removeAll()
    {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}
