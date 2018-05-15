//
//  Home.swift
//  Chnen
//
//  Created by navjot_sharma on 11/4/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire
class Home: NSObject
{
    var delegate :AnyObject!
    var handler :Selector? = nil
    
    var homePageSection = [[String: Any]]()
    var resultText = String()
    var message = String()
    var default_store_id = String()
    var arrStores = [Home]()
    var arrcurrency = [Home]()
    
    var store_id = String()
    var name = String()
    var is_active = String()
    var code = String()
    
    //MARK: Home Page Api
    
    func homepageApi(dict:[String: Any], target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+HOME_PAGE, selector: #selector(fillHomePageData(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func fillHomePageData (_ responseDict : [String: Any])
    {
        let objHome = Home()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                print(response)
                
                objHome.resultText = ksuccess
                if let _ = response[kcurrency] as? String {
                    globalStrings.currencyIcon = response[kcurrency] as! String
                }
                if let _ = response[kVisitorId] as? String {
                    globalStrings.Visitor_id =  response[kVisitorId] as! String
                }

                if let _ = response[khomepagesection] as? [[String: Any]] {
                    objHome.homePageSection = response[khomepagesection] as! [[String: Any]]
                }
            }
        }
        else
        {
            objHome.resultText = kisFail
            objHome.message = responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objHome, waitUntilDone: true)
    }
    
    //MARK: Get Store List
    func GetStoreListApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+GET_STORE_LIST, selector: #selector(fillStoreListResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func fillStoreListResponse (_ responseDict : [String: Any]) {
        let objHome = Home()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                objHome.resultText = ksuccess
                if let _ = response[kdefault_store_id] as? String {
                    objHome.default_store_id = response[kdefault_store_id] as! String
                }
                if let stores = response[kstores] as? [[String: Any]] {
                    for store in stores
                    {
                        let obj = Home()
                        if let _ = store[kcode] as? String{
                            obj.code = store[kcode] as! String
                        }
                        
                        if let _ = store[kname] as? String{
                            obj.name = store[kname] as! String
                        }
                        
                        if let _ = store[kis_active] as? String{
                            obj.is_active = store[kis_active] as! String
                        }
                        
                        if let _ = store[kstore_id] as? String{
                            obj.store_id = store[kstore_id] as! String
                        }
                        objHome.arrStores.append(obj)
                    }
                }
                if let stores = response[kcurrency] as? [[String: Any]] {
                    for store in stores {
                        let obj = Home()
                        
                        
                        if let _ = store[kname] as? String{
                            obj.name = store[kname] as! String
                        }
                        objHome.arrcurrency.append(obj)
                        
                    }
                }
            }
        } else
        {
            objHome.resultText = kisFail
            objHome.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objHome, waitUntilDone: true)
    }
}
