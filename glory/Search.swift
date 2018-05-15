//
//  Search.swift
//  Chnen
//
//  Created by Navjot Sharma on 11/24/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire


class Search: NSObject {
    
    var resultText = String()
    var message = String()
    var delegate :AnyObject!
    var handler :Selector? = nil
    var category_id = String()
    var name = String()
    var final_price = String()
    var image = String()
    var arrCategories = [Search]()
    var arrProducts = [String]()
    var inWishlist = String()
    var productId = String()
    var typeId = String()
    
    //MARK: Search Form Api API
    
    func SearchFormApi(dict:Parameters, target:AnyObject, selector:Selector) {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_SEARCHFORM_DATA, selector: #selector(FillSearchFormResponse(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func FillSearchFormResponse (_ responseDict : [String: Any]) {
        let objSearch = Search()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objSearch.resultText = ksuccess
            if let response = responseDict[kresponse] as? [String: Any] {
                for dict in (response[kCategories] as? [[String: Any]])! {
                    let obj = Search()
                    if let _ = dict[kcategory_id] as? String {
                        obj.category_id = dict[kcategory_id] as! String
                    }
                    if let _ = dict[kname] as? String {
                        obj.name = dict[kname] as! String
                    }
                    objSearch.arrCategories.append(obj)
                }
                if let _ = response[kproducts] as? [String] {
                    objSearch.arrProducts = response[kproducts] as! [String]
                }
            }
        } else
        {
            objSearch.resultText = kisFail
            objSearch.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objSearch, waitUntilDone: true)
    }
    
    //MARK: Get Search API
    
    func getSearchApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_SEARCH, selector: #selector(FillGetSearchResponse(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func FillGetSearchResponse (_ responseDict : [String: Any]) {
        var objSearch = [Search]()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if let response = responseDict[kresponse] as? [[String: Any]] {
                for dict in response {
                    let obj = Search()
                    obj.resultText = ksuccess
                    if let _ = dict[kfinal_price] as? String {
                        obj.final_price = dict[kfinal_price] as! String
                    }
                    if let _ = dict[ktype_id] as? String {
                        obj.typeId = dict[ktype_id] as! String
                    }
                    if let _ = dict[kproduct_id] as? String {
                        obj.productId = dict[kproduct_id] as! String
                    }
                    if let _ = dict[kimage] as? String {
                        obj.image = dict[kimage] as! String
                    }
                    if let _ = dict[kname] as? String {
                        obj.name = dict[kname] as! String
                    }
                    if let _ = dict[kinWishlist] as? String {
                        obj.inWishlist = dict[kinWishlist] as! String
                    }
                    objSearch.append(obj)
                }
            }
            
        } else
        {
            let obj = Search()
            obj.resultText = kisFail
            obj.message =  responseDict[kresponse] as! String
            objSearch.append(obj)
        }
        delegate.performSelector(onMainThread: handler!, with:objSearch, waitUntilDone: true)
    }
    
}
