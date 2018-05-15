//
//  Order.swift
//  Chnen
//
//  Created by Navjot Sharma on 12/7/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

class Order: NSObject {
    
    var delegate :AnyObject!
    var handler :Selector? = nil
    var resultText = String()
    var message = String()
    var more = Bool()
    var arrOrder = [Order]()
    var order_id = String()
    var arrProducts = [Order]()
    var name = String()
    var price = String()
    var image = String()
    var method_name = String()
    var grand_total = String()
    var qty_ordered = String()
    var shipping_description = String()
    var shipping_total = String()
    var tax = String()
    var discount = String()
    var email = String()
    var firstname = String()
    var lastname = String()
    var items = [Order]()
    var final_price = String()
    var id = String()
    var img_url = String()
    var qty = String()
    var subtotal = String()
    var shipping_city = String()
    var shipping_country_id = String()
    var shipping_country_name = String()
    var shipping_firstname = String()
    var shipping_lastname = String()
    var shipping_state = String()
    var shipping_street = String()
    var shipping_telephone = String()
    var shipping_zipcode = String()
    var billing_city = String()
    var billing_country_id = String()
    var billing_country_name = String()
    var billing_firstname = String()
    var billing_lastname = String()
    var billing_state = String()
    var billing_street = String()
    var billing_telephone = String()
    var billing_zipcode = String()
    var is_virtual = String()
    var status = String()
    var created = String()
    var weight = String()
        
    //MARK: Order List Api
    
    func  OrderListApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + ORDER_LIST, selector: #selector(fillOrderListResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func fillOrderListResponse (_ responseDict : [String: Any]) {
        let objOrder = Order()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                objOrder.resultText = ksuccess
                if let _ = response[kmore] as? Bool{
                    objOrder.more = response[kmore] as! Bool
                }
                if let _ = response[kOrder] as? [[String: Any]] {
                    for i in response[kOrder] as! [[String: Any]] {
                        let objO = Order()
                        if let _ = i[korder_id] as? String{
                            objO.order_id = i[korder_id] as! String
                        }
                        if let _ = i[kproducts] as? [[String: Any]] {
                            for j in i[kproducts] as! [[String: Any]] {
                                let objP = Order()
                                if let _ = j[kname] as? String{
                                    objP.name = j[kname] as! String
                                }
                                if let _ = j[kprice] as? String{
                                    objP.price = j[kprice] as! String
                                }
                                if let _ = j[kimage] as? String{
                                    objP.image = j[kimage] as! String
                                }
                                objO.arrProducts.append(objP)
                            }
                        }
                        objOrder.arrOrder.append(objO)
                    }
                }
            }
        } else
        {
            objOrder.resultText = kisFail
            objOrder.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objOrder, waitUntilDone: true)
    }
    
    //MARK: Order delete API
    
    func  OrderDeteteApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + CANCEL_ORDER, selector: #selector(fillOrderDeleteResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    
    func fillOrderDeleteResponse (_ responseDict : [String: Any])
    {
        print(responseDict)
        
        let objOrder = Order()
        let result = (responseDict[kreturnCode] as! [String : Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                print(response)
                objOrder.resultText = ksuccess
            }
        }
        else
        {
            objOrder.resultText = kisFail
            objOrder.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objOrder, waitUntilDone: true)
    }

    //MARK: Order Detail API
    
    func  OrderDetailApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + ORDER_INFO, selector: #selector(fillOrderDetailResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func fillOrderDetailResponse (_ responseDict : [String: Any]) {
        
        print(responseDict)
        
        let objOrder = Order()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                print(response)
                objOrder.resultText = ksuccess
                if let payment = response["payment"] as? [String:Any] {
                    if let _ = payment["method_name"] as? String
                    {
                        objOrder.method_name = payment["method_name"] as! String
                    }
                }
                if let _ = response["order_id"] as? String
                {
                    objOrder.order_id = response["order_id"] as! String
                }
                if let _ = response["status"] as? String
                {
                    objOrder.status = response["status"] as! String
                }
                
                if let _ = response["shipping_description"] as? String
                {
                    objOrder.shipping_description = response["shipping_description"] as! String
                }
                
                if let _ = response["shipping_total"] as? String
                {
                    objOrder.shipping_total = response["shipping_total"] as! String
                }
                if let _ = response["discount"] as? String
                {
                    objOrder.discount = response["discount"] as! String
                }
                if let _ = response["subtotal"] as? String
                {
                    objOrder.subtotal = response["subtotal"] as! String
                }
                if let _ = response["tax"] as? String
                {
                    objOrder.tax = response["tax"] as! String
                }
                if let _ = response["grand_total"] as? String
                {
                    objOrder.grand_total = response["grand_total"] as! String
                }
                if let _ = response["qty_ordered"] as? String
                {
                    objOrder.qty_ordered = response["qty_ordered"] as! String
                }
                if let _ = response["created"] as? Int
                {
                    objOrder.created = String(response["created"] as! Int)
                }
                if let _ = response["weight"] as? String
                {
                    objOrder.weight = response["weight"] as! String
                }
                if let _ = response["is_virtual"] as? String
                {
                    objOrder.is_virtual = response["is_virtual"] as! String
                }
                
                if let customer_info = response["customer_info"] as? [String: Any] {
                    if let _ = customer_info["email"] as? String
                    {
                        objOrder.email = customer_info["email"] as! String
                    }
                    if let _ = customer_info["firstname"] as? String
                    {
                        objOrder.firstname = customer_info["firstname"] as! String
                    }
                    if let _ = customer_info["lastname"] as? String
                    {
                        objOrder.lastname = customer_info["lastname"] as! String
                    }
                }
                if let items = response["items"] as? [[String: Any]] {
                    for dict in items {
                        let obj = Order()
                        if let _ = dict["final_price"] as? String
                        {
                            obj.final_price = dict["final_price"] as! String
                        }
                        if let _ = dict["id"] as? String
                        {
                            obj.id = dict["id"] as! String
                        }
                        if let _ = dict["img_url"] as? String
                        {
                            obj.img_url = dict["img_url"] as! String
                        }
                        if let _ = dict["name"] as? String
                        {
                            obj.name = dict["name"] as! String
                        }
                        if let _ = dict["qty"] as? String
                        {
                            obj.qty = dict["qty"] as! String
                        }
                        objOrder.items.append(obj)
                    }
                }
                if let shipping_address = response["shipping_address"] as? [String: Any] {
                    if let _ = shipping_address["city"] as? String {
                        objOrder.shipping_city = shipping_address["city"] as! String
                    }
                    if let _ = shipping_address["country_id"] as? String {
                        objOrder.shipping_country_id = shipping_address["country_id"] as! String
                    }
                    if let _ = shipping_address["country_name"] as? String {
                        objOrder.shipping_country_name = shipping_address["country_name"] as! String
                    }
                    if let _ = shipping_address["firstname"] as? String {
                        objOrder.shipping_firstname = shipping_address["firstname"] as! String
                    }
                    if let _ = shipping_address["lastname"] as? String {
                        objOrder.shipping_lastname = shipping_address["lastname"] as! String
                    }
                    if let _ = shipping_address["state"] as? String {
                        objOrder.shipping_state = shipping_address["state"] as! String
                    }
                    if let _ = shipping_address["street"] as? String {
                        objOrder.shipping_street = shipping_address["street"] as! String
                    }
                    if let _ = shipping_address["telephone"] as? String {
                        objOrder.shipping_telephone = shipping_address["telephone"] as! String
                    }
                    if let _ = shipping_address["zipcode"] as? String {
                        objOrder.shipping_zipcode = shipping_address["zipcode"] as! String
                    }
                }
                if let billing_address = response["billing_address"] as? [String: Any] {
                    if let _ = billing_address["city"] as? String {
                        
                        objOrder.billing_city = billing_address["city"] as! String
                    }
                    if let _ = billing_address["country_id"] as? String {
                        
                        objOrder.billing_country_id = billing_address["country_id"] as! String
                    }
                    if let _ = billing_address["country_name"] as? String {
                        
                        objOrder.billing_country_name = billing_address["country_name"] as! String
                    }
                    if let _ = billing_address["firstname"] as? String {
                        
                        objOrder.billing_firstname = billing_address["firstname"] as! String
                    }
                    if let _ = billing_address["lastname"] as? String {
                        
                        objOrder.billing_lastname = billing_address["lastname"] as! String
                    }
                    if let _ = billing_address["state"] as? String {
                        
                        objOrder.billing_state = billing_address["state"] as! String
                    }
                    if let _ = billing_address["street"] as? String {
                        
                        objOrder.billing_street = billing_address["street"] as! String
                    }
                    if let _ = billing_address["telephone"] as? String {
                        
                        objOrder.billing_telephone = billing_address["telephone"] as! String
                    }
                    if let _ = billing_address["zipcode"] as? String {
                        
                        objOrder.billing_zipcode = billing_address["zipcode"] as! String
                    }
                }
            }
        } else
        {
            objOrder.resultText = kisFail
            objOrder.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objOrder, waitUntilDone: true)
    }
}
