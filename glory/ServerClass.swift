//
//  ServerClass.swift
//  Chnen
//
//  Created by User on 07/07/17.
//  Copyright © 2017 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

class ServerClass: NSObject
{
    static let sharedInstance = ServerClass()
    var savedUrl = String()
    var savedSelector : Selector?
    var savedDelegate : AnyObject?
    var savedParameters = [String : Any]()
    var savedMethod = HTTPMethod(rawValue: "post")
    
    func connectToServerWithRequest(url : String, selector : Selector, delegate : AnyObject, dict : [String : Any], method : HTTPMethod) {
        print(url, dict)
        if Reachability.isConnectedToNetwork() {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            manager.request(url, parameters: dict).responseJSON
                {
                    response in
                    print(response.request!)
                    print(response.result)
                    
                    if let JSON = response.result.value
                    {
                        print("JSON: \(JSON)")
                        delegate.performSelector(onMainThread: selector, with:JSON, waitUntilDone: true)
                    }
                    else
                    {
                        print(response.result.value ?? "")
                        let responseDict = [kreturnCode : [kresultText : kisFail] , kresponse : SomethingWrong] as [String : Any]
                        delegate.performSelector(onMainThread: selector, with:responseDict, waitUntilDone: true)
                    }
            }
        } else
        {
            let responseDict = [kreturnCode : [kresultText : kisFail] , kresponse : noInternet] as [String : Any]
            delegate.performSelector(onMainThread: selector, with: responseDict, waitUntilDone: true)
        }
    }
}



