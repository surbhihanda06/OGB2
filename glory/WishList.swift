//
//  WishList.swift
//  Chnen
//
//  Created by Navjot Sharma on 11/22/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire


class WishList: NSObject
{
    var resultText = String()
    var message = String()
    var delegate :AnyObject!
    var handler :Selector? = nil
    var wishlistItemId = String()
    var product_image = String()
    var product_id = String()
    var product_name = String()
    var name = String()
    var price = String()
    
    
    //MARK: Wishlist API
    
    func WishListApi(dict:Parameters, target:AnyObject, selector:Selector) {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_WISHLIST_ITEMS, selector: #selector(fillWishlistResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func fillWishlistResponse (_ responseDict : [String: Any]) {
        var objWishList = [WishList]()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                if let _ = response[kWishlistItems] as? [[String: Any]] {
                    for dict in response[kWishlistItems] as! [[String: Any]]
                    {
                        let obj = WishList()
                        obj.resultText = ksuccess
                        if let _ = dict[kname] as? String {
                            obj.name = dict[kname] as! String
                        }
                        if let _ = dict[kprice] as? String {
                            obj.price = dict[kprice] as! String
                        }
                        if let _ = dict[kproduct_image] as? String {
                            obj.product_image = dict[kproduct_image] as! String
                        }
                        if let _ = dict[kproduct_name] as? String {
                            obj.product_name = dict[kproduct_name] as! String
                        }
                        if let _ = dict[kwishlist_item_id] as? String {
                            obj.wishlistItemId = dict[kwishlist_item_id] as! String
                        }
                        if let _ = dict[kproduct_id] as? String {
                            obj.product_id = dict[kproduct_id] as! String
                        }
                        objWishList.append(obj)
                    }
                    if objWishList.count == 0
                    {
                        let  obj = WishList()
                        obj.resultText = kisFail
                        obj.message = ""
                        objWishList.append(obj)
                    }
                }
            }
        } else
        {
            let  obj = WishList()
            obj.resultText = kisFail
            obj.message =  responseDict[kresponse] as! String
            objWishList.append(obj)
        }
        delegate.performSelector(onMainThread: handler!, with:objWishList, waitUntilDone: true)
    }
    
    //MARK: Delete From Wishlist API
    
    func DeleteFromWishListApi(dict:Parameters, target:AnyObject, selector:Selector) {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+removeWishListItem, selector: #selector(fillDeleteWishlistResponse(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func fillDeleteWishlistResponse (_ responseDict : [String: Any]) {
        let objWishList = WishList()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objWishList.resultText = ksuccess
            if let _ = responseDict[kresponse] as? String {
                objWishList.message = responseDict[kresponse] as! String
            }
        } else
        {
            objWishList.resultText = kisFail
            objWishList.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objWishList, waitUntilDone: true)
    }
}
