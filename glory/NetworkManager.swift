//
//  NetworkManager.swift
//  Chnen
//
//  Created by user on 14/05/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {

    //MARK:- Connect Server
    static func connectToServer(url : String, dict : [String : Any], method : HTTPMethod, completion: @escaping (_ json:[String:Any]?)->Void) {
        
        print("url: \(url)")
        print("parameters: \(dict)")
        
        if Reachability.isConnectedToNetwork() {
            
            activityIndicator.startAnimating(activityData)
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            manager.request(url, parameters: dict).responseJSON {
                response in
                
                activityIndicator.stopAnimating()
                
                print("response: \(response.result.value)")
                
                if let json : [String:Any] = response.result.value as? [String : Any], let result = (json[kreturnCode] as! [String: Any])[kresultText] as? String {
                    
                    // handle already registered user response (compulsion)
                    if let response = json[kresponse] as? [String:Any],let message = response[kmessage] as? String,message == customerAlreadyExist {
                        completion(json)
                        return
                    }
                    
                    if  result  == ksuccess {
                        completion(json)
                    }
                    else {
                        completion(nil)
                        if let failure = json[kresponse] as? [String: Any], let message = failure[kresponse_msg] as? String {
                            AlertManager.showAlert(type: .custom(message))
                        } else {
                            AlertManager.showAlert(type: .serverNotResponding)
                        }
                    }
                }
                else {
                    completion(nil)
                    AlertManager.showAlert(type: .serverNotResponding)
                }
            }
        }
        else {
            completion(nil)
            AlertManager.showAlert(type: .networkUnavailable)
        }
    }
    
    //MARK: Register API
    static func registerApi(dict:Parameters, completion: @escaping (Bool)->Void) {
        
        NetworkManager.connectToServer(url: BASE_URL+REGISTRATION, dict: dict, method: .get) { (result) in
            
            guard let json = result else {
                completion(false)
                return
            }
            
            if  let response = json[kresponse] as? [String: Any] {
                if let cust_id = response[kcust_id] as? String {
                    globalStrings.Cust_id = cust_id
                    defaults.setValue(cust_id, forKey: dcust_id)
                    defaults.set(true, forKey: dis_login)
                }
            }
            completion(true)
        }
    }
    
    // MARK: Login API
    static func login(_ parameter: [String:Any], completion: @escaping (Bool)->Void) {
        
        NetworkManager.connectToServer(url: BASE_URL+LOGIN, dict: parameter, method: .get) { (result) in
            
            guard let json = result else {
                completion(false)
                return
            }
            
            if  let response = json[kresponse] as? [String: Any] {
                
                if let cust_id = response[kcust_id] as? String {
                    globalStrings.Cust_id = cust_id
                    defaults.setValue(cust_id, forKey: dcust_id)
                    defaults.set(true, forKey: dis_login)
                }
                if let quote_id = response[kquote_id] as? String {
                    globalStrings.Quote_id = quote_id
                    defaults.setValue(quote_id, forKey: dquote_id)
                }
                if let quote_count = response[kquote_count] as? Int {
                    globalStrings.Quote_count = quote_count
                    defaults.setValue(quote_count, forKey: dquote_count)
                }
            }
            
            completion(true)
        }
    }
}
