//
//  Facebook.swift
//  Burst
//
//  Created by Harish Garg on 10/10/17.
//  Copyright © 2017 Harish Garg. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

/*class Facebook: NSObject {

    var delegate :AnyObject!
    var handler :Selector? = nil
    var returnDelegate : AnyObject?
    var returnSelector : Selector?
  
     func getFbData(_ target:AnyObject, selector:Selector) {
        delegate = target
        handler = selector
      let fbLoginManager = FBSDKLoginManager()
        
        /*Facebook Login Behaviour*/
        fbLoginManager.loginBehavior = FBSDKLoginBehavior.browser
        fbLoginManager.logOut()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: target as! UIViewController, handler: {(result, error) in
            if error != nil {
                print("Error FB")
                print(error!.localizedDescription)
                let errorim : [String:String] = ["code":"0","result":"error"]
                let dictResult :[String:AnyObject] = ["response":errorim as AnyObject]
                self.delegate.performSelector(onMainThread: self.handler!, with:dictResult, waitUntilDone: true)

            } else if (result?.isCancelled)! {
                print("CancelledFB")//If result cancelled
                let error : [String:AnyObject] = ["code":"1" as AnyObject,"result":"Cancelled" as AnyObject]
                let dictResult :[String:AnyObject] = ["response":error as AnyObject]
                self.delegate.performSelector(onMainThread: self.handler!, with:dictResult, waitUntilDone: true)
            } else {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, picture.width(800).height(800), email, name, id, gender,location"]).start(completionHandler: {(connection, result, error) -> Void in
                    if error != nil{
                        print("Error : \(error.debugDescription)")
                    } else {
                        print("DataFetchedFB")
                        let fbAccessToken = FBSDKAccessToken.current().tokenString
                        var dictResponse : [String:AnyObject] = ["code":"200" as AnyObject,"result":result! as AnyObject]
                        dictResponse["FBToken"] = fbAccessToken as AnyObject?
                        let dictResult :[String:AnyObject] = ["response":dictResponse as AnyObject]
                        print(dictResult)
                        self.delegate.performSelector(onMainThread: self.handler!, with:dictResult, waitUntilDone: true)
                    }
                })
            }
        })
    }
}*/
