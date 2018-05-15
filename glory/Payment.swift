//
//  Payment.swift
//  Chnen
//
//  Created by navjot_sharma on 12/8/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

class Payment: NSObject
{
    var delegate :AnyObject!
    var handler :Selector? = nil
    var resultText = String()
    var message = String()
    var code = String()
    var title = String()
    var carrier_title = String()
    var price_excl_tax = String()
    var method_code = String()
    var carrier_code = String()
    var arrPayments = [Payment]()
    var arrShipMethods = [Payment]()
    var subtotal = String()
    var discount = String()
    var shipCost = String()
    var grandTotal = String()
    var orderId = String()
    
    //MARK: Get Methods API
    
    func GetMethodsApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_METHODS, selector: #selector(fillGetMethodsResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func fillGetMethodsResponse (_ responseDict : [String: Any]) {
        let objPayment = Payment()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                objPayment.resultText = ksuccess
                for dict in (response[kpayment] as? [[String: Any]])!{
                 let obj = Payment()
                    if let _ = dict[kcode] as? String{
                        obj.code = dict[kcode] as! String
                    }
                    if let _ = dict[ktitle] as? String{
                        obj.title = dict[ktitle] as! String
                    }
                    objPayment.arrPayments.append(obj)
                }
                for dict in (response[kship_method] as? [[String: Any]])!{
                    let obj = Payment()
                    if let _ = dict[kcarrier_title] as? String{
                        obj.carrier_title = dict[kcarrier_title] as! String
                    }
                    if let _ = dict[kmethod_code] as? String{
                        obj.method_code = dict[kmethod_code] as! String
                    }
                    if let _ = dict[kcarrier_code] as? String{
                        obj.carrier_code = dict[kcarrier_code] as! String
                    }
                    if let _ = dict[kprice_excl_tax] as? String{
                        obj.price_excl_tax = dict[kprice_excl_tax] as! String
                    }
                    objPayment.arrShipMethods.append(obj)
                }
            }
        } else
        {
            objPayment.resultText = kisFail
            objPayment.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objPayment, waitUntilDone: true)
    }
    
     //MARK: Assign Ship to Quote API
    
    func AssignShipToQuoteApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+ASSIGN_SHIP_TO_QUOTE, selector: #selector(AssignShipToQuoteResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func AssignShipToQuoteResponse (_ responseDict : [String: Any]) {
        let objPayment = Payment()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
               objPayment.resultText = ksuccess
                if let str = response[ksubtotal] as? [String:Any] {
                    objPayment.subtotal = str[kvalue] as! String
                }
                if let str = response[kdiscount] as? [String:Any] {
                    objPayment.discount = str[kvalue] as! String
                }
                if let str = response[kship_charge] as? [String:Any] {
                    objPayment.shipCost = str[kvalue] as! String
                }
                if let str = response[kgrandtotal] as? [String:Any] {
                    objPayment.grandTotal = str[kvalue] as! String
                }
                
            }
        } else
        {
            objPayment.resultText = kisFail
            objPayment.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objPayment, waitUntilDone: true)
    }
    
    //MARK: Assign Payment to Quote API
    
    func AssignPaymentToQuoteApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")

        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+ASSIGN_PAYMENT_TO_QUOTE, selector: #selector(AssignPaymentToQuoteResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func AssignPaymentToQuoteResponse (_ responseDict : [String: Any]) {
        let objPayment = Payment()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                objPayment.resultText = ksuccess
                if let str = response[ksubtotal] as? [String:Any] {
                    objPayment.subtotal = str[kvalue] as! String
                }
                if let str = response[kdiscount] as? [String:Any] {
                    objPayment.discount = str[kvalue] as! String
                }
                if let str = response[kship_charge] as? [String:Any] {
                    objPayment.shipCost = str[kvalue] as! String
                }
                if let str = response[kgrandtotal] as? [String:Any] {
                    objPayment.grandTotal = str[kvalue] as! String
                }
            }
        } else
        {
            objPayment.resultText = kisFail
            objPayment.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objPayment, waitUntilDone: true)
    }

    func PlaceOrderApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+PLACE_ORDER, selector: #selector(FillPlaceOrderResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func FillPlaceOrderResponse (_ responseDict : [String: Any]) {
        let objPayment = Payment()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? String
            {
                objPayment.resultText = ksuccess
                objPayment.orderId = response
            }
        } else
        {
            objPayment.resultText = kisFail
            objPayment.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objPayment, waitUntilDone: true)
    }
    

    
}
