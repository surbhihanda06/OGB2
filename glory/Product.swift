//
//  Product.swift
//  Chnen
//
//  Created by navjot_sharma on 11/16/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire
class Product: NSObject
{
    var delegate :AnyObject?
    var handler :Selector?
    var resultText = String()
    var response = [String:Any]()
    var id = String()
    var product_url = String()
    var title    = String()
    var inStock = Int()
    var link_selection_required = String()
    var links_purchased_separately = String()
    var prepend_link = String()
    var images = [[String:Any]]()
    var message = String()
    var name = String()
    var label = String()
    var image = String()
    var sku = String()
    var finalPrice = String()
    var isDescHtml = Bool()
    var strDescription = String()
    var specification = [[String:Any]]()
    var options = [[String:Any]]()
    var bundle_Values = [[String:Any]]()
    var grouped_Values = [[String:Any]]()
    var inWishlist = String()
    var productId = String()
    var typeID = String()
    var code = String()
    var value = String()
    var arrProducts = [Product]()
    var arrFilters = [Product]()
    var arrOptions = [Product]()
    var more = Bool()
    var attributes = [[String: Any]]()
    var sample     = [[String: Any]]()
    var rows     = [[String: Any]]()
    var links      = [String: Any]()
    var media_url = String()
    var wishlist_item_id = String()
    
    //MARK: Product List API
    func productListApi(dict:[String: Any], target:AnyObject, selector:Selector)
    {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+PRODUCT_LIST, selector: #selector(fillProductList(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func fillProductList (_ responseDict : [String: Any]) {
        let objProducts = Product()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            let response = responseDict[kresponse] as! [String: Any]
            objProducts.resultText = ksuccess
            for arr in response[kproduct] as! [[String: Any]] {
                let objProduct = Product()
                if let _ = arr[kname] as? String {
                    objProduct.name = arr[kname] as! String
                }
                if let _ = arr[kimage] as? String {
                    objProduct.image = arr[kimage] as! String
                }
                if let _ = arr[kfinal_price] as? String {
                    objProduct.finalPrice = arr[kfinal_price] as! String
                }
                if let _ = arr[kinWishlist] as? String {
                    objProduct.inWishlist = arr[kinWishlist] as! String
                }
                if let _ = arr[kproduct_id] as? String {
                    objProduct.productId = arr[kproduct_id] as! String
                }
                if let _ = arr[ktype_id] as? String {
                    objProduct.typeID = arr[ktype_id] as! String
                }
                objProducts.arrProducts.append(objProduct)
            }
            for arr in response[kfilters] as! [[String: Any]] {
                let obj = Product()
                if let _ = arr[klabel] as? String {
                    obj.label = arr[klabel] as! String
                }
                if let _ = arr[koptions] as? [[String: Any]] {
                    for arr in arr[koptions] as! [[String: Any]] {
                        let objProduct = Product()
                        
                        if let _ = arr[klabel] as? String {
                            objProduct.label = arr[klabel] as! String
                        }
                        if let _ = arr[kcode] as? String {
                            objProduct.code = arr[kcode] as! String
                        }
                        if let _ = arr[kvalue] as? String {
                            objProduct.value = arr[kvalue] as! String
                        }
                        obj.arrOptions.append(objProduct)
                    }
                }
                objProducts.arrFilters.append(obj)
            }
            if let _ = response[kmore] as? Bool {
                objProducts.more = response[kmore] as! Bool
            }
        } else
        {
            objProducts.resultText = kisFail
            objProducts.message =  responseDict[kresponse] as! String
        }
        delegate?.performSelector(onMainThread: handler!, with:objProducts, waitUntilDone: true)
    }
    
    //MARK: Add Wishlist API
    
    func AddWishlistApi(dict:[String: Any], target:AnyObject, selector:Selector) {
        
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+addProductToWishList, selector: #selector(fillAddWishlistResponse(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func fillAddWishlistResponse (_ responseDict : [String: Any]) {
        let objProducts = Product()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if let response = responseDict[kresponse] as? String {
                objProducts.message = response
            }
            if let wishlist_item_id = responseDict[kwishlist_item_id] as? String {
                objProducts.wishlist_item_id = wishlist_item_id
            }
            objProducts.resultText = ksuccess
        } else
        {
            objProducts.message =  responseDict[kresponse] as! String
            if let response = responseDict[kresponse] as? String {
                objProducts.message = response
            }
            objProducts.resultText = kisFail
        }
        delegate?.performSelector(onMainThread: handler!, with:objProducts, waitUntilDone: true)
    }
    
    //MARK: Remove Wishlist API
    
    func RemoveWishlistApi(dict:[String: Any], target:AnyObject, selector:Selector) {
        
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+removeWishListItem, selector: #selector(fillRemoveWishlistResponse(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func fillRemoveWishlistResponse (_ responseDict : [String: Any]) {
        let objProducts = Product()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if let response = responseDict[kresponse] as? String {
                objProducts.message = response
            }
            objProducts.resultText = ksuccess
        } else
        {
            objProducts.message =  responseDict[kresponse] as! String
            if let response = responseDict[kresponse] as? String {
                objProducts.message = response
            }
            objProducts.resultText = kisFail
        }
        delegate?.performSelector(onMainThread: handler!, with:objProducts, waitUntilDone: true)
    }
    
    //MARK: Product Detail API
    
    func ProductDetailApi(dict:[String: Any], target:AnyObject, selector:Selector) {
        
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+PRODUCT_DETAIL, selector: #selector(fillProductDetailResponse(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func fillProductDetailResponse (_ responseDict : [String: Any]) {
        
        let objProducts = Product()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if let response = responseDict[kresponse] as? [String: Any] {
                if let _ = response[kImages] as? [[String:Any]] {
                    objProducts.images = response[kImages] as! [[String:Any]]
                }
                if let _ = response[kid] as? String {
                    objProducts.id = response[kid] as! String
                }
                if let _ = response[kname] as? String {
                    objProducts.name = response[kname] as! String
                }
                if let _ = response[kfinal_price] as? String {
                    objProducts.finalPrice = response[kfinal_price] as! String
                }
                if let _ = response[kis_desc_html] as? Bool {
                    objProducts.isDescHtml = response[kis_desc_html] as! Bool
                }
                if let _ = response[kdescription] as? String {
                    objProducts.strDescription = response[kdescription] as! String
                }
                if let _ = response[kwishlist_item_id] as? String {
                    
                    print(response[kwishlist_item_id] as? String)
                    objProducts.inWishlist = response[kwishlist_item_id] as! String
                }
                if let _ = response[kspecification] as? [[String: Any]] {
                    objProducts.specification = response[kspecification] as! [[String: Any]]
                }
                if let _ = response[kproduct_url] as? String {
                    objProducts.product_url = response[kproduct_url] as! String
                }
                if let _ = response[kInStock] as? String {
                    objProducts.inStock = response[kInStock] as! Int
                }
                
                if let _ = response[ksku] as? String {
                    objProducts.sku = response[ksku] as! String
                }
                if let config_attributes = response[kconfig_attributes] as? [String:Any] {
                    if let _ = config_attributes[kattributes] as? [[String: Any]]{
                        objProducts.attributes = config_attributes[kattributes] as! [[String: Any]]
                    }
                    if let _ = config_attributes[kmedia_url] as? String {
                        objProducts.media_url = config_attributes[kmedia_url] as! String
                    }
                }
                if let options = response[koptions] as? [[String: Any]]
                {
                    objProducts.options = options
                }
                
                if let downloadable_options = response[kdownloadable_options] as? [String:Any]
                {
                    if let samples = downloadable_options[ksamples] as? [[String : Any]] {
                        objProducts.sample = samples
                    }
                    
                    if let link = downloadable_options[klinks] as? [String : Any]
                    {
                        objProducts.links = link
                        
                        if let row = link[krows] as? [[String : Any]]
                        {
                            objProducts.rows = row
                        }
                    }
                }
                
                if let bundle_options = response[kbundle_options] as? [[String:Any]]
                {
                    objProducts.bundle_Values = bundle_options
                }
                
                if let grouped_Options = response[kassociated] as? [[String:Any]]
                {
                    objProducts.grouped_Values = grouped_Options
                }
            }
            objProducts.resultText = ksuccess
        } else
        {
            if let response = responseDict[kresponse] as? String {
                objProducts.message = response
            }
            objProducts.resultText = kisFail
        }
        delegate?.performSelector(onMainThread: handler!, with:objProducts, waitUntilDone: true)
    }
    
    //MARK: Add To Cart API
    
    func AddtoCartApi(dict:[String: Any], target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+ADD_TO_CART, selector: #selector(fillAddToCartResponse(_:)), delegate: self, dict: dict, method: .post)
    }
    
    func fillAddToCartResponse (_ responseDict : [String: Any]) {
        let objProducts = Product()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objProducts.resultText = ksuccess
            if let response = responseDict[kresponse] as? [String: Any] {
                if let _ = response[kmsg] as? String {
                    objProducts.message = response[kmsg] as! String
                }
                if let quote_id = response[kquote_id] as? String {
                    globalStrings.Quote_id = quote_id
                    defaults.set(globalStrings.Quote_id, forKey: dquote_id)
                }
                if let quote_count = response[kquote_count] as? Int {
                    globalStrings.Quote_count = quote_count
                    defaults.set(globalStrings.Quote_count, forKey: dquote_count)
                }
            }
        } else
        {
            if let response = responseDict[kresponse] as? [String: Any] {
                if let _ = response[kmsg] as? String {
                    objProducts.message = response[kmsg] as! String
                }
                if let quote_id = response[kquote_id] as? String {
                    globalStrings.Quote_id = quote_id
                    defaults.set(globalStrings.Quote_id, forKey: dquote_id)
                }
                if let quote_count = response[kquote_count] as? Int {
                    globalStrings.Quote_count = quote_count
                    defaults.set(globalStrings.Quote_count, forKey: dquote_count)
                }
            }
            objProducts.resultText = kisFail
        }
        delegate?.performSelector(onMainThread: handler!, with:objProducts, waitUntilDone: true)
    }
    
}
