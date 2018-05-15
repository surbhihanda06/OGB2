//
//  Cart.swift
//  Chnen
//
//  Created by navjot_sharma on 11/24/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire
class Cart: NSObject
{
    var delegate :AnyObject!
    var handler :Selector? = nil
    var resultText = String()
    var message = String()
    var image = String()
    var arrProducts = [Cart]()
    var grandtotal = String()
    var name = String()
    var price = String()
    var qty = Int()
    var item_id = String()
    var prod_Id = String()
    var is_virtual = Bool()
    var billingAddress = String()
    var shippingAddress = String()
    var subtotal = String()
    var discount = String()
    var shipCost = String()
    var custaddr = Bool()
    
     //MARK: Cart Detail API
    
    func cartDetailApi(dict:Parameters, target:AnyObject, selector:Selector) {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + CART_DETAIL, selector: #selector(FillCartDetailResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func FillCartDetailResponse (_ responseDict : [String: Any]) {
        let objCart = Cart()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                print(response)
                if let _ = response[kproducts] as? [[String: Any]] {
                    for dict in response[kproducts] as! [[String: Any]] {
                        let obj = Cart()
                        if let _ = dict[kimage] as? String {
                            obj.image = dict[kimage] as! String
                        }
                        if let _ = dict[kprod_Id] as? String {
                            obj.prod_Id = dict[kprod_Id] as! String
                        }
                        if let _ = dict[kname] as? String {
                            obj.name = dict[kname] as! String
                        }
                        if let _ = dict[kqty] as? Int {
                            obj.qty = dict[kqty] as! Int
                        }
                        if let _ = dict[kprice] as? String {
                            obj.price = dict[kprice] as! String
                        }
                        if let _ = dict[kitem_id] as? String {
                            obj.item_id = dict[kitem_id] as! String
                        }
                        objCart.arrProducts.append(obj)
                    }
                    if let _ = response[kquote_count] as? Int {
                     globalStrings.Quote_count = response[kquote_count] as! Int
                     defaults.set(globalStrings.Quote_count, forKey: dquote_count)
                    }
                    if let _ = response[kgrandtotal] as? String {
                        objCart.grandtotal = response[kgrandtotal] as! String
                    }
                    if let _ = response[ksubtotal] as? String {
                        objCart.subtotal = response[ksubtotal] as! String
                    }
                    if let _ = response[kship_cost] as? String {
                        objCart.shipCost = response[kship_cost] as! String
                    }
                    if let _ = response[kdiscount] as? String {
                        objCart.discount = response[kdiscount] as! String
                    }
                    if let _ = response[kis_virtual] as? Bool {
                        objCart.is_virtual = response[kis_virtual] as! Bool
                    }
                    if let billing = response[kbilling_addr] as? [String: Any] {
                        objCart.billingAddress = billing[kas_html] as! String
                    }
                    if let shipping = response[kshipping_addr] as? [String: Any]{
                        objCart.shippingAddress = shipping[kas_html] as! String
                    }
                    if let _ = response[kcust_has_addr] as? Bool {
                        objCart.custaddr = response[kcust_has_addr] as! Bool
                    }
                    objCart.resultText = ksuccess
                }
            }
        } else
        {
            objCart.resultText = kisFail
            objCart.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objCart, waitUntilDone: true)
    }
    
     //MARK: Delete From Cart API
    
    func DeleteFromCart(dict:Parameters, target:AnyObject, selector:Selector) {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + DELETE_FROM_CART, selector: #selector(FillDeleteFromCartResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func FillDeleteFromCartResponse (_ responseDict : [String: Any]) {
        let objCart = Cart()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objCart.resultText = ksuccess
        } else
        {
            objCart.resultText = kisFail
            objCart.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objCart, waitUntilDone: true)
    }
    
     //MARK: Upadte Cart API
    
    func UpdateCart(dict:Parameters, target:AnyObject, selector:Selector) {
        
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + UPDATE_CART, selector: #selector(FillUpdateCartResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func FillUpdateCartResponse (_ responseDict : [String: Any]) {
        let objCart = Cart()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
           objCart.resultText = ksuccess
        } else
        {
            objCart.resultText = kisFail
            objCart.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objCart, waitUntilDone: true)
    }
    
     //MARK: Move to Wishlist API
    
    func MoveToWishlist(dict:Parameters, target:AnyObject, selector:Selector) {
        
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL + MOVE_TO_WISHLIST, selector: #selector(MoveToWishlistResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func MoveToWishlistResponse (_ responseDict : [String: Any]) {
        let objCart = Cart()
        
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objCart.resultText = ksuccess
        } else
        {
            objCart.resultText = kisFail
            objCart.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objCart, waitUntilDone: true)
    }
}
