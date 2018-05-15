//
//  FacebookManager.swift
//  Chnen
//
//  Created by user on 14/05/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookManager: NSObject {
    
    var gender: String = ""
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    var completion : ((_ json: FacebookManager) -> Void)? = nil
    static let sharedInstance = FacebookManager()
    
    override init() {
        // initialization
    }
    
    // initialize facebook data
    init(_ json: [String:Any]) {
        
        gender = (json["gender"] as? String ?? "Male") == "female" ? "2" : "1"
        email = json["email"] as! String
        firstName = json["first_name"] as! String
        lastName = json["last_name"] as! String
    }
    
    // Login Facebook
    static func login(target:UIViewController, completion: ((_ json: FacebookManager)->())?) {
        
        sharedInstance.completion = completion
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: target) { (result, error) in
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        FacebookManager.facebookAPI()
                        fbLoginManager.logOut()
                    }
                }
            } else {
                sharedInstance.completion = nil
            }
        }
    }
    
    // Facebook Login API
    static func facebookAPI() {
        
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, gender,picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                guard error == nil, let json = result as? [String:Any] else {
                    sharedInstance.completion = nil
                    return
                }
                let facebookData = FacebookManager(json)
                sharedInstance.completion!(facebookData)
            })
        }
    }
}
