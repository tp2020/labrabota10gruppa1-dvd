//
//  UserDefaultHelper.swift
//  Hotels booking
//
//  Created by Viktor on 5/10/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import Foundation

class UserDefaultHelper{
    static func saveStringValue(key: String, value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    static func getStringValue(key: String) -> String{
        let defaults = UserDefaults.standard
        guard let string = defaults.string(forKey: key) else {
            return "key_not_found"
        }
        return string
    }
    static func isKeyExist(key: String)->Bool{
        let defaults = UserDefaults.standard
        guard let string = defaults.string(forKey: key) else {
            return false
        }
        return true
    }
}
