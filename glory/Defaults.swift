//
//  Defaults.swift
//  Chnen
//
//  Created by user on 14/05/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//

import UIKit

class Defaults {

    // device id
    static var deviceId : String! {
        set {
            UserDefaults.standard.set(newValue, forKey: ddevice_id)
        }
        get {
            if let id : String = UserDefaults.standard.object(forKey: ddevice_id) as? String {
                return id
            }
            else {
                return ""
            }
        }
    }
    
}
