//
//  AlertManager.swift
//  Chnen
//
//  Created by user on 14/05/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//

import UIKit

enum Prompt {
    
    case networkUnavailable
    case serverNotResponding
    case custom(String)
        
    var message: String? {
        
        switch self {
        case .networkUnavailable:
            return noInternet
        case .serverNotResponding:
            return SomethingWrong
        case .custom(let message):
            return message
        }
    }
}

class AlertManager {
    
    static func showAlert(type: Prompt) {
        
        let alert = UIAlertController.init(title: nil, message: type.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {Void in})
        alert.addAction(action)
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let controller = delegate.window?.rootViewController else { return }
        
        controller.present(alert, animated: true, completion: nil)
    }
}
